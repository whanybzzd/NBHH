//
//  TestTableViewCell.swift
//  NBHHDemo
//
//  Created by ZMJ on 2018/6/24.
//  Copyright © 2018年 jktz. All rights reserved.
//

import UIKit

class TestTableViewCell: UITableViewCell {

   fileprivate lazy var nameLabel:UILabel=UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle=UITableViewCellSelectionStyle.none
        initSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension TestTableViewCell{
    
    func initSubView()->Void {
        nameLabel.text="卧槽"
        nameLabel.textColor=UIColor.orange
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(10)
            make.top.equalTo(10)
            //让宽度大于等于100
            make.width.greaterThanOrEqualTo(100)
            //让宽度大于等于self.contentView
            //make.width.greaterThanOrEqualTo(self.contentView)
            make.height.equalTo(15)
        }
    }
    
    
    func initSubViewData(model:CustomerList) -> Void {
        
        nameLabel.text=model.name
    }
}
