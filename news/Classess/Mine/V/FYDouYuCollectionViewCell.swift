//
//  FYDouYuCollectionViewCell.swift
//  news
//
//  Created by wang on 2018/9/12.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit

class FYDouYuCollectionViewCell: UICollectionViewCell {
    
    var icon : UIImageView!
    var titleLabel : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setupUI()
    }
    
    func setupUI() {
        icon = UIImageView()
        contentView.addSubview(icon)
        icon.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.height.width.equalTo(50)
        }
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(icon.snp.bottom).offset(10)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(model:FYDouYuModel) {
        icon.sd_setImage(with: (NSURL(string: model.square_icon_url!)! as URL), completed: nil)
        titleLabel.text = model.cate2_name
    }
    
}
