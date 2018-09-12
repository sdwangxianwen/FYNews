//
//  FYHomeViewController.swift
//  news
//
//  Created by wang on 2018/9/10.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit
import YYModel
import MJRefresh

class FYHomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var pageNUm : NSInteger!
    var tableView : UITableView!
    var arrm : NSMutableArray?
    override func viewDidLoad() {
        super.viewDidLoad()
        pageNUm = 0
        arrm = NSMutableArray(array: [])
        initTableView()
        networking()
    }
    //MARK:创建tableView
    func initTableView()  {
        tableView = UITableView(frame: view.frame, style: .plain)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self;
        tableView.register(KKTableViewCell.self, forCellReuseIdentifier: "KKTableViewCellID")
        tableView.mj_header = MJRefreshGifHeader.init(refreshingTarget: self, refreshingAction: #selector(downFresh))
        tableView.mj_footer = MJRefreshFooter.init(refreshingTarget: self, refreshingAction: #selector(pullLoad))
    }
    //MARK:tableview的代理和数据源方法
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrM.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : KKTableViewCell = tableView.dequeueReusableCell(withIdentifier: "KKTableViewCellID", for: indexPath) as! KKTableViewCell
        let model = arrM[indexPath.row] as! kkModel
        cell.setModel(model: model)
        return cell
    }
    
    //MARK:下拉刷新
    @objc func downFresh() {
        pageNUm = 0
        arrm?.removeAllObjects()
        networking()
    }
    //MARK:上拉加载
    @objc func pullLoad() {
        pageNUm = pageNUm + 1
        networking()
    }
    
    //MARK:网络请求
    func networking()  {
        FYNetManager.shared.requestDataWithTargetJSON(target: HomeAPI.kankanList(pageNUm), successClosure: { (response) in
            print(response)
            let arr = NSArray.yy_modelArray(with: kkModel.self, json: response["comics"].rawValue) as! [kkModel]
            if arr.count > 0  {
                self.arrM.addObjects(from: arr)
            }
            else {
                self.pageNUm = max(self.pageNUm - 1, 0)
            }
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            self.tableView.reloadData()
        }) { (error) in
            print(error ?? (Any).self)
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
        }
    }
    
    //MARK:懒加载
    lazy var arrM  = { () -> NSMutableArray in
        let arrM = NSMutableArray(array: [])
        return arrM
    }()
}
