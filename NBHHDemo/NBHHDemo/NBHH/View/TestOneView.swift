//
//  TestOneView.swift
//  NBHHDemo
//
//  Created by jktz on 2018/6/25.
//  Copyright © 2018年 jktz. All rights reserved.
//

import UIKit

class TestOneView: UIView,UITableViewDelegate,UITableViewDataSource {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.OnetableView)
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
        
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TestOneTableViewCell
        cell.textLabel?.text="我帅不~~~"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
}
