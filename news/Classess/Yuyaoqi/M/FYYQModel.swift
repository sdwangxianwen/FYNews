//
//  FYYQModel.swift
//  news
//
//  Created by wang on 2018/9/19.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit

//分类的模型

//@property (nonatomic, strong) NSString * argName;
//@property (nonatomic, strong) NSString * argValue;
//@property (nonatomic, assign) BOOL canChange;
//@property (nonatomic, assign) BOOL canMore;
//@property (nonatomic, assign) long comicType;
//@property (nonatomic, strong) NSArray<comics *> * comics;
//@property (nonatomic, strong) NSString * description;
//@property (nonatomic, strong) NSString * itemTitle;
//@property (nonatomic, strong) NSString * newTitleIconUrl;
//@property (nonatomic, assign) long nextPage;
//@property (nonatomic, strong) NSString * sortId;
//@property (nonatomic, strong) NSString * titleIconUrl;

@objcMembers class comicsModel: NSObject {
    var argName : String?
    var cover : String?
    var itemTitle : String?
    var name : String?
//    @property (nonatomic, assign) long argCon;
//    @property (nonatomic, strong) NSString * argName;
//    @property (nonatomic, assign) long argValue;
//    @property (nonatomic, strong) NSString * cover;
//    @property (nonatomic, assign) BOOL isClassify;
//    @property (nonatomic, strong) NSString * itemTitle;
//    @property (nonatomic, strong) NSString * name;
    
}

@objcMembers class comicLists: NSObject {
    var argName : String?
    var argValue : String?
    var itemTitle : String?
    var newTitleIconUrl : String?
    var sortId : String?
    var titleIconUrl : String?
    var comics : [comicsModel] = []
    
    func commic() -> NSDictionary {
        return [comics : comicsModel()]
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
