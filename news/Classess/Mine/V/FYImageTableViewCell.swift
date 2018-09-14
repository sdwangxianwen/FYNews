//
//  FYImageTableViewCell.swift
//  news
//
//  Created by wang on 2018/9/14.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit

class FYImageTableViewCell: UITableViewCell {
    
    var icon : UIImageView!
    
    var offset : CGFloat? {
        get {
            return self.offset
        }
        set(offset) {
            var new_y = -(offset!/2.0);
            if new_y > 0 {
                new_y = 0
            }  else if new_y  < self.frame.height - icon.frame.height {
                new_y = self.frame.height - icon.frame.height
            }
      
            icon.frame = CGRect(x: 0, y: new_y, width: icon.frame.size.width, height: icon.frame.size.height*1.5)
//            icon.snp.makeConstraints { (make) in
//                make.top.equalToSuperview().offset(new_y)
//                make.left.equalToSuperview().offset(0)
//                make.width.equalTo(contentView.frame.size.width)
//                make.height.equalTo(contentView.frame.size.height)
//            }
        }
    }
    
    var model : imageList? {
        get {
            return self.model
        }
        
        set(model) {
//            icon.sd_setImage(with: (NSURL(string: (model?.cover_url)!)! as URL), completed: nil)
            icon.sd_setImage(with: (NSURL(string: (model?.cover_url)!)! as URL), placeholderImage: UIImage(named: ""), options: .delayPlaceholder, completed: nil)
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        icon = UIImageView.init()
        icon.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200)
        icon.contentMode = UIViewContentMode.scaleAspectFill
        icon.clipsToBounds = true
       
        self.contentView.addSubview(icon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
//        icon.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//        }
    }
    
    
    func cellOnTableView(tableView:UITableView,view:UIView){
          // 将cell的frame转换成view的Frame(为了获取每个cell的Y值)
        let rect = tableView.convert(self.frame, to: view)
        //视图的frame的一半 减去 所看到的每个CellY值(获取滚动的值)
        //以屏幕中心点为0点 获取能看到的每个Cell离中心点得值是多少
        let distanceCenter = view.frame.size.height/2 - rect.minY;
        // 图片高度 - cell的高度 (获取图片超出cell高度部分)图片肯定要比cell大，否则不会有视觉差效果
//        float difference = CGRectGetHeight(self.backgroundImage.frame) - CGRectGetHeight(self.frame);
        let difference = icon.frame.size.height - self.frame.size.height
         let imageMove = (distanceCenter / view.frame.size.height) * difference
        //旧的图片Frame
        var imageRect = self.icon.frame
        //移动
        imageRect.origin.y = imageMove - (difference/2)
        //新的图片Frame
        icon.contentMode = UIViewContentMode.scaleAspectFill
        icon.clipsToBounds = true
        self.icon.frame = imageRect;
        
    }
    
}
