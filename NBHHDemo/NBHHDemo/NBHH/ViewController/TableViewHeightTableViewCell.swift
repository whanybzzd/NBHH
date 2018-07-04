//
//  TableViewHeightTableViewCell.swift
//  NBHHDemo
//
//  Created by jktz on 2018/7/4.
//  Copyright © 2018年 jktz. All rights reserved.
//

import UIKit
import Kingfisher
class TableViewHeightTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initSubView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubView() -> Void {
        
        self.contentView.addSubview(averImage)
        averImage.snp.makeConstraints { (make) in
            
            make.top.left.equalTo(self.contentView).offset(15)
            make.width.height.equalTo(50)
        }
        
        self.contentView.addSubview(nicklabel)
        nicklabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(averImage.snp.right).offset(15)
            make.right.equalTo(self.contentView).offset(-15)
            make.height.top.equalTo(15)
        }
        
        self.contentView.addSubview(contentlabel)
        contentlabel.snp.makeConstraints { (make) in
            
            make.left.right.equalTo(nicklabel)
            make.top.equalTo(nicklabel.snp.bottom).offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        
    }
    
    lazy var averImage:UIImageView={
        
        let averimageView=UIImageView()
        averimageView.backgroundColor=UIColor.red
        averimageView.layer.cornerRadius=25
        averimageView.layer.masksToBounds=true
        return averimageView
    }()
    
    
    lazy var nicklabel:UILabel={
        
        let label=UILabel()
        label.text="我曹"
        label.textColor=UIColor.brown
        label.font=UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var contentlabel:UILabel={
        
       let content=UILabel()
        content.textColor=UIColor.blue
        content.font=UIFont.systemFont(ofSize: 15)
        content.numberOfLines=0
        return content
    }()
    
    
    func imageViewUrl(url:String) -> Void {
        
         let url=URL(string: url)
        let placeholder=UIImage.init(named: "")
        
        let task=averImage.kf.setImage(with: url, placeholder: placeholder, options: nil, progressBlock: { (receivedSize, totalSize) in
            
             //print("Download Progress: \(receivedSize)/\(totalSize)")
        }) { (image, error, type, url) in
            
            //print("image:\(String(describing: image)),error:\(String(describing: error)),type:\(type),url:\(String(describing: url))")
        }
        task.cancel()
    }
}
