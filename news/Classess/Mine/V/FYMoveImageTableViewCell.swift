//
//  FYMoveImageTableViewCell.swift
//  news
//
//  Created by wang on 2018/9/14.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit

class FYMoveImageTableViewCell: UITableViewCell {

  
    @IBOutlet weak var backgroundImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
         self.clipsToBounds = true
    }
    
    func cellOnTableView(tableView:UITableView,view:UIView){
        // 将cell的frame转换成view的Frame(为了获取每个cell的Y值)
        let rect = tableView.convert(self.frame, to: view)
        //视图的frame的一半 减去 所看到的每个CellY值(获取滚动的值)
        //以屏幕中心点为0点 获取能看到的每个Cell离中心点得值是多少
        let distanceCenter = view.frame.size.height/2 - rect.minY;
        // 图片高度 - cell的高度 (获取图片超出cell高度部分)图片肯定要比cell大，否则不会有视觉差效果
        //        float difference = CGRectGetHeight(self.backgroundImage.frame) - CGRectGetHeight(self.frame);
        let difference = backgroundImage.frame.size.height - self.frame.size.height
        let imageMove = (distanceCenter / view.frame.size.height) * difference
        //旧的图片Frame
        var imageRect = self.backgroundImage.frame
        //移动
        imageRect.origin.y = imageMove - (difference/2)
        //新的图片Frame
        self.backgroundImage.frame = imageRect;
        
    }
    
    var model : imageList? {
        get {
            return self.model
        }
        
        set(model) {
            backgroundImage.sd_setImage(with: (NSURL(string: (model?.cover_url)!)! as URL), placeholderImage: UIImage(named: ""), options: .delayPlaceholder, completed: nil)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
