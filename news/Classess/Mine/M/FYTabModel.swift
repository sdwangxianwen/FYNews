//
//  FYTabModel.swift
//  news
//
//  Created by wang on 2018/9/14.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit

@objcMembers class tabVerticalModel: NSObject {
  @objc  var icon : String?
  @objc   var tabName : String?
   @objc  var type : String?
   @objc  var vipTag : String?
    var tabType :String?
    
}

@objcMembers class tabHorizontalModel: NSObject {
  @objc   var icon : String?
  @objc   var tabName : String?
  @objc   var type : String?
  @objc   var vipTag : String?
    var tabType :String?
}

@objcMembers class FYTabModel: NSObject {
    var tabHorizontal : [tabHorizontalModel]?
    var tabVertical : [tabVerticalModel]?
  
   func tab() -> NSDictionary {
    return ["tabVertical": tabVerticalModel.self ,"tabHorizontal": tabHorizontalModel.self]
    }
    
 
}

@objcMembers  class imageList: NSObject {
    var cover_url : String?
}


