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
        
        label_text = UILabel()
        label_text.layer.cornerRadius = 1
        label_text.clipsToBounds = true
        label_text.font = UIFont.systemFont(ofSize: 13)
        contentView.addSubview(label_text)
        label_text.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
        }
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(label_text.snp.right).offset(15)
            make.centerY.equalTo(label_text.snp.centerY)
        }
        
        authorLabel = UILabel()
        authorLabel.font = UIFont.systemFont(ofSize: 15)
        contentView.addSubview(authorLabel)
        authorLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
        }
        
        icon = UIImageView()
        contentView.addSubview(icon)
        icon.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(0)
            make.top.equalTo(authorLabel.snp.bottom).offset(15)
            make.right.equalTo(contentView).offset(0)
            make.height.equalTo(170)
        }
        
        subTitle = UILabel()
        contentView.addSubview(subTitle)
        subTitle.font = UIFont.systemFont(ofSize: 15)
        subTitle.snp.makeConstraints { (make) in
            make.top.equalTo(icon.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15)
            make.bottom.equalTo(contentView).offset(-15)
        }
    }
    
    func setModel(model:kkModel)  {
        label_text.text = model.label_text
        label_text.backgroundColor = UIColor().hexStringToColor(hexString: model.label_color!)
        titleLabel.text = model.topic?.title
        authorLabel.text = "作者:".appending(model.topic!.user!.nickname)
        subTitle.text = model.title
        icon.sd_setImage(with: URL(string: model.cover_image_url!)!, placeholderImage: UIImage.init(named: "Emptybig"), options: .allowInvalidSSLCertificates, completed: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
