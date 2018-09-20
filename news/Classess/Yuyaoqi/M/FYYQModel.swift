//
//  FYYQModel.swift
//  news
//
//  Created by wang on 2018/9/19.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit
import YYModel

@objcMembers class comicsModel: NSObject {
    var argName : String?
    var cover : String?
    var itemTitle : String?
    var name : String?    
}

@objcMembers class comicLists: NSObject{
    
    var argName : String?
    var argValue : String?
    var itemTitle : String?
    var newTitleIconUrl : String?
    var sortId : String?
    var titleIconUrl : String?
    var cover : String?
    var name : String?
    var comics : [comicsModel]?

    static func modelContainerPropertyGenericClass() -> [String : Any]? {
        return ["comics":comicsModel.classForCoder()]
    }
}

//轮播图的模型
@objcMembers class galleryItems: NSObject {
    var content : String?
    var cover : String?
    var id : String?
    var linkType : String?
    var title : String?
//    @property (nonatomic, strong) NSArray<ext *> * ext
}

class FYYQModel: NSObject {
    var galleryItems : [galleryItems]!
}
