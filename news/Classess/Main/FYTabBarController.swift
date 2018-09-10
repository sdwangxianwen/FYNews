//
//  FYTabBarController.swift
//  news
//
//  Created by wang on 2018/9/10.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit

class FYTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setChildViewControllers()
    }
    
    func setChildViewControllers() {
        setUpChildController(FYHomeViewController(), "首页", "", "")
        setUpChildController(FYZhiViewController(), "智库", "", "")
        setUpChildController(FYMeViewController(), "我的", "", "")
    }

    // 设置子控件属性
    private func setUpChildController(_ controller : UIViewController,_ title : String,_ norImage : String,_ selectedImage : String){
        
        controller.tabBarItem.title = title
        // 修改TabBar标题位置
        controller.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3)
        controller.tabBarItem.image = UIImage(named: norImage)
        controller.tabBarItem.selectedImage = UIImage(named: selectedImage)
        // 设置 NavigationController
        let nav = FYNavController(rootViewController: controller)
        controller.title = title
        self.addChildViewController(nav)
        
    }
   

}
