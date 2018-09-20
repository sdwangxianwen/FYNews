//
//  FYYaoQiBigIconTableViewCell.swift
//  news
//
//  Created by wang on 2018/9/20.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit

class FYYaoQiCateTableViewCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCateUI(modelArr:NSArray)  {
        let iconW : CGFloat = (self.contentView.width - 60)/4
        for i  in 0..<modelArr.count {
            let model = modelArr[i] as! comicsModel
            let iconX = CGFloat(i) * iconW + CGFloat(i + 1) * 15
            let smallIcon = UIImageView.init(frame: CGRect(x: iconX, y: 0, width: iconW, height: iconW))
            smallIcon.sd_setImage(with: NSURL(string: model.cover!)! as URL, placeholderImage: UIImage.init(named: ""), options: [], completed: nil)
            self.contentView.addSubview(smallIcon)
        }
    }
}

class FYYaoQiSmallIconTableViewCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI(modelArr:NSArray)  {
        let iconW = (self.contentView.width - 15*4)/3
        for i  in 1..<modelArr.count {
            let model = modelArr[i] as! comicsModel
            let iconX = CGFloat(i - 1) * iconW + CGFloat(i) * 15
            let smallIcon = UIImageView.init(frame: CGRect(x: iconX, y: 0, width: iconW, height: iconW))
            smallIcon.sd_setImage(with: NSURL(string: model.cover!)! as URL, placeholderImage: UIImage.init(named: ""), options: [], completed: nil)
            self.contentView.addSubview(smallIcon)
        }
    }
    
}

class FYYaoQiBigIconTableViewCell: UITableViewCell {
    @IBOutlet weak var bigIcoN: UIImageView!
    @IBOutlet weak var cateLabel: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupUI(model:comicsModel) {
         self.bigIcoN.sd_setImage(with: NSURL(string: model.cover!)! as URL, placeholderImage: UIImage.init(named: ""), options: [], completed: nil)
    }
    
}
