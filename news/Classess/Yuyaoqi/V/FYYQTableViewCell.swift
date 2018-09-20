//
//  FYYQTableViewCell.swift
//  news
//
//  Created by wang on 2018/9/20.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit

class FYYQTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(isBigIcon : Bool ,modelArr:NSArray)  {
        if isBigIcon {
            let model = modelArr.firstObject as! comicsModel
            self.contentView.addSubview(self.bigImage)
            self.bigImage.sd_setImage(with: NSURL(string: model.cover!)! as URL, placeholderImage: UIImage.init(named: ""), options: [], completed: nil)
        } else {
            let iconW = (self.contentView.width - 15*4)/3
            for i in 0...2 {
                let model = modelArr[i + 1] as! comicsModel
                let iconX = CGFloat(i) * iconW + CGFloat(i+1) * 15
                let smallIcon = UIImageView.init(frame: CGRect(x: iconX, y: 0, width: iconW, height: iconW))
                smallIcon.sd_setImage(with: NSURL(string: model.cover!)! as URL, placeholderImage: UIImage.init(named: ""), options: [], completed: nil)
                self.contentView.addSubview(smallIcon)
            }
        }
    }
    
    lazy var bigImage = {() -> UIImageView in
        let bgimage = UIImageView()
        bgimage.frame = self.contentView.frame
        
        return bgimage
    }()
    
}
