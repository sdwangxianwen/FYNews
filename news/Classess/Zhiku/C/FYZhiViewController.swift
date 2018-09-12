//
//  FYZhiViewController.swift
//  news
//
//  Created by wang on 2018/9/10.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit
import YYModel
import MJRefresh

class FYZhiViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
   
    var arrM : NSMutableArray!
    var tableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        arrM = NSMutableArray(array: []) //初始化可变数组
        initTableView()
        network()
    }
    
    //MARK:创建视图
    func initTableView()  {
        tableView = UITableView.init(frame: view.bounds)
        view.addSubview(tableView)
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FYZhiTableViewCell.self, forCellReuseIdentifier: "FYZhiTableViewCellID")
        tableView.mj_header = MJRefreshGifHeader.init(refreshingTarget: self, refreshingAction: #selector(pullFresh))
        tableView.mj_footer = MJRefreshAutoGifFooter.init(refreshingTarget: self, refreshingAction: #selector(pullFresh))
    }
    
    //MARK:下拉刷新
    @objc func pullFresh() {
        network()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrM.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : FYZhiTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FYZhiTableViewCellID", for: indexPath) as! FYZhiTableViewCell
        cell.backgroundColor = UIColor.white
        let model = arrM[indexPath.row] as! FYHomeModel
        cell.setModel(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    //MARK:网络请求
    func network() {
        FYNetManager.shared.requestDataWithTargetJSON(target: HomeAPI.zhiList, successClosure: { (response) in
            // 字典转模型
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            let cateArr  = NSArray.yy_modelArray(with: FYHomeModel.self, json: response.rawValue) as! [FYHomeModel]
            self.arrM.addObjects(from: cateArr)
            self.tableView.reloadData()
        }) { (error) in
            print(error as Any)
        }
    }
}
