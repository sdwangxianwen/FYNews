//
//  KKTableViewCell.swift
//  motaDemo
//
//  Created by wang on 2018/9/7.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class KKTableViewCell: UITableViewCell {
    
    var icon:UIImageView! //图片
    var label_text :UILabel! //分类
    var titleLabel :UILabel! //标题
    var authorLabel :UILabel! //作者
    var subTitle:UILabel! //副标题
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.label_text = UILabel()
        self.label_text.font = UIFont.systemFont(ofSize: 13)
        self.contentView.addSubview(self.label_text)
        self.label_text.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
        }
        
        self.titleLabel = UILabel()
        self.titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.label_text.snp.right).offset(15)
            make.centerY.equalTo(self.label_text.snp.centerY)
        }
        
        self.authorLabel = UILabel()
        self.authorLabel.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(self.authorLabel)
        self.authorLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(15)
        }
        
        self.icon = UIImageView()
        self.contentView.addSubview(self.icon)
        self.icon.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(0)
            make.top.equalTo(self.authorLabel.snp.bottom).offset(15)
            make.right.equalTo(self.contentView).offset(0)
            make.height.equalTo(170)
        }
        
        self.subTitle = UILabel()
        self.contentView.addSubview(self.subTitle)
        self.subTitle.font = UIFont.systemFont(ofSize: 15)
        self.subTitle.snp.makeConstraints { (make) in
            make.top.equalTo(self.icon.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15)
            make.bottom.equalTo(self.contentView).offset(-15)
        }
        

    }
    
    func setModel(model:kkModel)  {
        self.label_text.text = model.label_text
        self.titleLabel.text = model.topic?.title
        self.authorLabel.text = "作者:".appending(model.topic!.user!.nickname)
        self.subTitle.text = model.title
        self.icon.sd_setImage(with: URL(string: model.cover_image_url!)!, placeholderImage: UIImage.init(named: "Emptybig"), options: .allowInvalidSSLCertificates, completed: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
