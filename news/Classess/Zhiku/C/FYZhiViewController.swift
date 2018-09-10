//
//  FYZhiViewController.swift
//  news
//
//  Created by wang on 2018/9/10.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit
import YYModel


class FYZhiViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var arrM : NSMutableArray!
    var tableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.arrM = NSMutableArray(array: []) //初始化可变数组
        self.initTableView()
        self.network()
    }
    
    //MARK:创建视图
    func initTableView()  {
        self.tableView = UITableView.init(frame: self.view.bounds)
        self.view.addSubview(self.tableView)
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(FYZhiTableViewCell.self, forCellReuseIdentifier: "FYZhiTableViewCellID")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrM.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : FYZhiTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FYZhiTableViewCellID", for: indexPath) as! FYZhiTableViewCell
        cell.backgroundColor = UIColor.white
        let model = self.arrM[indexPath.row] as! FYHomeModel
        cell.setModel(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    //MARK:网络请求
    func network() {
        FYNetManager.shared.requestDataWithTargetJSON(target: HomeAPI.recommendCategoryList, successClosure: { (response) in
            // 字典转模型
            let cateArr  = NSArray.yy_modelArray(with: FYHomeModel.self, json: response.rawValue) as! [FYHomeModel]
            self.arrM.addObjects(from: cateArr)
            self.tableView.reloadData()
        }) { (error) in
            print(error as Any)
        }
    }
    
    

}
