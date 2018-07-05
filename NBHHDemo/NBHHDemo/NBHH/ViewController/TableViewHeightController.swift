//
//  TableViewHeightController.swift
//  NBHHDemo
//
//  Created by jktz on 2018/7/4.
//  Copyright © 2018年 jktz. All rights reserved.
//

import UIKit

class TableViewHeightController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var dataArray:Array<Any>=Array<Any>()
    var imageArray:Array<Any>=Array<Any>()
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.zz_viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //导航栏设置
        self.navBarBgAlpha = 0
        self.navBarTintColor = UIColor.defaultNavBarTintColor
        self.navBarColor = UIColor.init(red: 1, green: 0, blue: 0, alpha: 1)
        
        self.navBarTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)]
        
        
        
        //TODO:测试数据
        dataArray.append("设计的佛我翻脸施蒂利克史莱克的房间里金石可镂带饭了路附近路口啥都放假我房间里的沙基拉就是了； ")
        dataArray.append("设计的佛我翻脸施蒂利克史莱克的房间里金石可镂带饭了路附近路口啥都放假我房间里的沙基拉就是了； 水电费的说法是打算发斯蒂芬所发生的放松放松风飒飒服务费撒是飞洒发是发顺丰按时发士大夫撒飞洒发顺丰水电费")
        dataArray.append("设计的佛我翻脸施蒂利克史莱克的房间里金石可镂带饭了路附近路口啥都放假我房间里的沙基拉就是了；沙发沙发上沙发是范德萨发斯蒂芬看风景看了反馈律师代理费开了房就是两份近段时间辅导老师水电费吉林省发简历到书房里的书房里的书房里的设计费连接是否洛索洛芬简单来说；反倒是电视 ")
        dataArray.append("设计的佛我翻脸施蒂利克史莱克的房间里金石可镂带饭了路附近路口啥都放假我房间里的沙基拉就是了； 是两地分居老司机斐林试剂带饭了斯蒂芬斯蒂芬吉拉拉闪乱神乐废旧塑料法拉盛解放路；市解放路；是发劳斯莱斯就发了文件附件搜房家乐福就是两份简单来说；附件")
        dataArray.append("设计的佛我翻脸施蒂利克史莱克的房间里金石可镂带饭了路附近路口啥都放假我房间里的沙基拉就是了； 见识到了积分来我家老司机法拉利吉林省福建省了房间里；市解放路就是两份就是了；放假啊历史记录；书法家李；爱上了；阿精神分裂；杀了富家大室了；附件代理商；废旧塑料；发简历；按时缴费了；市解放路")
        
        imageArray=["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530689635484&di=138c0a149c319c290a1e576cd5b076e5&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F012d145a94479aa80121923198253a.jpg%401280w_1l_2o_100sh.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530689649888&di=7015c6b7997e20b73dc3e4b3b9cd7d4c&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0157a85925bf97b5b3086ed4d37e89.jpg%40900w_1l_2o_100sh.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530689649888&di=021cd94bce7761a578922db0dfc812f6&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F012b5d56f5f9456ac7257948d807a5.jpg%40900w_1l_2o_100sh.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530689649887&di=4f2e9de671de7c24ff1b556746c3a6c3&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01312b56f5fa0e32f875a944908a8e.jpg%40900w_1l_2o_100sh.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1530689649887&di=0db07cbce6e442685f8187a768ff89da&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01e7ef57c83ce80000018c1b037806.jpg%402o.jpg"]
        self.view.addSubview(OnetableView)
        
    }

    lazy var OnetableView:UITableView={()->UITableView in
        
        let tableView=UITableView(frame: CGRect(x: 0, y: height!, width: SCREEN_WIDTH, height:SCREEN_HEIGHT-height!), style: .plain)
        tableView.register(TableViewHeightTableViewCell.self, forCellReuseIdentifier: "cell1")
        tableView.delegate=self
        tableView.dataSource=self
        tableView.estimatedRowHeight=44
        tableView.rowHeight=UITableViewAutomaticDimension
        return tableView
    }()
}


extension TableViewHeightController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TableViewHeightTableViewCell
        cell.nicklabel.text=String(format:"我的名字为无法第三方第三方士大夫你的第：\(indexPath.row)行")
        cell.contentlabel.text=self.dataArray[indexPath.row] as? String
        cell.imageViewUrl(url: self.imageArray[indexPath.row] as! String)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        
        self.scrollViewDidNav(scrollView: scrollView)
    }
    
    
}
