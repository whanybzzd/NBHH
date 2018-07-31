//
//  TestOneView.swift
//  NBHHDemo
//
//  Created by jktz on 2018/6/25.
//  Copyright © 2018年 jktz. All rights reserved.
//

import UIKit
import YLImagePickerController
class TestOneView: UIView,UITableViewDelegate,UITableViewDataSource {

    var listdataArray=[String]()//定义一个数组
    var imagePickerController:YLImagePickerController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.OnetableView)
        
        listdataArray=["单选不裁剪","单选方形裁剪","单选圆形裁剪","多选","拍照不裁剪","拍照方形裁剪"]
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var OnetableView:UITableView={()->UITableView in
        
        let tableView=UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: self.height), style: .plain)
        tableView.register(TestOneTableViewCell.self, forCellReuseIdentifier: "cell1")
        tableView.delegate=self
        tableView.dataSource=self
        //头部视图
        tableView.tableHeaderView=self.headView
        return tableView
    }()
    
    lazy var headView:TestOneHeadView={()->TestOneHeadView in
        
        let tableHeadView=TestOneHeadView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 200*KSCREEN_HEIGHT))
        return tableHeadView
        
    }()
    
    func bannerArray (banner:[Any]) -> Void {
        
        self.headView.sdScrollView.imageURLStringsGroup=banner
    }

}

extension TestOneView{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listdataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TestOneTableViewCell
        cell.textLabel?.text=listdataArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            imagePickerController=YLImagePickerController.init(imagePickerType: .album, cropType: .none)
        case 1:
            imagePickerController=YLImagePickerController.init(imagePickerType: .album, cropType: .square)
        case 2:
            imagePickerController=YLImagePickerController.init(imagePickerType: .album, cropType: .circular)
        case 3:
            imagePickerController=YLImagePickerController.init(maxImagesCount: 3)
        case 4:
            imagePickerController=YLImagePickerController.init(imagePickerType: .camera, cropType: .none)
        case 5:
            imagePickerController=YLImagePickerController.init(imagePickerType: .camera, cropType: .none)
        default:
            break
        }
        
        
        //是否可以选择gif
        imagePickerController?.isNeedSelectGifImage=true
        
        //是否可以选择视频
        imagePickerController?.isNeedSelectVideo=true
        
        imagePickerController?.didFinishPickingPhotosHandle={(photos: [YLPhotoModel]) in
            
            for photo in photos {
                
                if photo.type == YLAssetType.photo {
                    
                    print("图片:")
                    print(photo.image ?? "")
                }else if photo.type == YLAssetType.gif {
                    
                    print("gif:")
                    print(photo.data  ?? "")
                    
                }else if photo.type == YLAssetType.video {
                    
                    print("Video:")
                    print(photo.data ?? "")
                    
                }
            }
        }
        let baseVC=UIView.currentViewController() as! BaseViewController
        baseVC .present(imagePickerController!, animated: true, completion: nil)
    }
}
