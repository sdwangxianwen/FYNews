//
//  FYHomeViewController.swift
//  news
//
//  Created by wang on 2018/9/10.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit
import YYModel

class FYHomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        FYNetManager.shared.requestDataWithTargetJSON(target: HomeAPI.kankanList, successClosure: { (response) in
            print(response)
        }) { (error) in
            print(error ?? (Any).self)
        }
       
    }

   
}
