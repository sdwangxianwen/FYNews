//
//  FYZhiTableViewCell.swift
//  news
//
//  Created by wang on 2018/9/10.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import SDWebImage

class FYZhiTableViewCell: UITableViewCell {
    
    var titleLabel : UILabel!
    var icon : UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
      super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() -> Void {
        
        self.icon = UIImageView()
        self.contentView.addSubview(self.icon)
        self.icon.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.width.equalTo(60)
//            make.bottom.equalTo(self.contentView.snp.bottom).offset(-15)
        }
        
        self.titleLabel = UILabel()
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.titleLabel.numberOfLines = 0
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalTo(self.icon.snp.centerY)
            make.right.equalTo(self.icon.snp.left).offset(-30)
        }
    }
    
    func setModel(model:FYHomeModel) -> Void {
        self.titleLabel.text = model.microTitle
//        let strig = model.imgurl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//        self.icon.sd_setImage(with: (NSURL(string: strig!)! as URL), completed: nil)
        if let imgUrl = URL(string:(model.imgurl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!)  {
            self.icon.kf.setImage(with: imgUrl)
        }else{
            self.icon.image = UIImage(named: "anchorImage_placeHolder")
        }
    }
    

}
