//
//  FYColor.swift
//  news
//
//  Created by wang on 2018/9/12.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit


extension UIColor {
    public func hexStringToColor(hexString: String) -> UIColor{
        var cString: String = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        if cString.count < 6 {
            return UIColor.black
        }
        if cString.hasPrefix("0x") {
            cString = String( cString.suffix(from: cString.index(cString.startIndex, offsetBy: 2)))
        }
        if cString.hasPrefix("#") {
            cString = String(cString.suffix(from: cString.index(cString.startIndex, offsetBy: 1)))
        }
        if cString.count != 6 {
            return UIColor.black
        }
        var range: NSRange = NSMakeRange(0, 2)
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        Scanner.init(string: rString).scanHexInt32(&r)
        Scanner.init(string: gString).scanHexInt32(&g)
        Scanner.init(string: bString).scanHexInt32(&b)
        return UIColor(displayP3Red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(1))
    }
}


extension UIView {
    
    var width : CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var frame = self.frame
            frame.size.width = self.width
            self.frame = frame;
        }
    }
    
    var height : CGFloat {
        get {
            return self.frame.size.height
        }
        
        set {
            var frame = self.frame
            frame.size.height = self.height
            self.frame = frame
        }
    }
    
    var left : CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var frame = self.frame;
            frame.origin.x = self.left
            self.frame = frame;
        }
    }
    
    var top : CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var frame = self.frame;
            frame.origin.y = self.top
            self.frame = frame;
        }
    }
    
    var right : CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        set {
            var frame = self.frame;
            frame.origin.x = self.right - frame.size.width;
            self.frame = frame;
        }
    }
    
    var bottom : CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        }
        set {
            var frame = self.frame;
            frame.origin.y = self.bottom - frame.size.height;
            self.frame = frame;
        }
    }
    
    var centerX : CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center = CGPoint(x: self.centerX, y: self.center.y)
        }
    }
    
    var centerY : CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center = CGPoint(x: self.center.x, y: self.centerY)
        }
    }
}

extension UIViewController {
    
     /// 状态栏高度
    var statusBarHeight : CGFloat {
        get {
            return UIApplication.shared.statusBarFrame.size.height
        }
    }
    //导航栏高度+状态栏高度
    var mNavigationbarHeight : CGFloat {
        get {
             return self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.size.height
        }
    }
    //tabBar高度
    var mTabbarHeight : CGFloat {
        get {
           return self.tabBarController!.tabBar.bounds.size.height
        }
    }
}
