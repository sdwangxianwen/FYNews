//
//  FYYaoQiViewController.swift
//  news
//
//  Created by wang on 2018/9/19.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit
import SDCycleScrollView

class FYYaoQiViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate {
    var bannerView : SDCycleScrollView! = nil
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        netWorking()
        view.addSubview(tableView)
    }
    
    
    func netWorking()  {
        FYNetManager.shared.requestDataWithTargetJSON(target: HomeAPI.yqshopList, successClosure: { (response) in
           print(response)
            //轮播图的网络请求
            let arr = NSArray.yy_modelArray(with: galleryItems.self, json: response["returnData"]["galleryItems"].rawValue) as! [galleryItems]
            for bannerModel in arr {
                self.bannerM.add(bannerModel.cover as Any)
            }
            self.bannerView.imageURLStringsGroup = (self.bannerM as! [Any])
            
            let arr1 = NSArray.yy_modelArray(with:comicLists.self , json:response["returnData"]["comicLists"].rawValue ) as! [comicLists]
            self.sectionsArrM.addObjects(from: arr1)
            self.tableView.reloadData()
           
        }) { (error) in
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsArrM.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 2
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        let label = UILabel.init(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 60))
         let model = sectionsArrM[section] as! comicLists
        label.text = model.itemTitle
        label.textAlignment = .center
        label.textColor = UIColor.brown
        return label
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.01
        }
        return 60
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        }
        if indexPath.row == 0  && indexPath.section != 0{
            return 300
        } else {
            return (self.view.width - 40)/3
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sectionsArrM[indexPath.section] as! comicLists
        let comModel = model.comics![indexPath.row]
        
        if indexPath.row == 0 && indexPath.section != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FYYaoQiBigIconTableViewCellID", for: indexPath) as! FYYaoQiBigIconTableViewCell
            cell.setupUI(model: comModel)
            
            return cell
        }
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FYYaoQiCateTableViewCellID", for: indexPath) as! FYYaoQiCateTableViewCell
            cell.setupCateUI(modelArr: model.comics! as NSArray)
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "FYYaoQiSmallIconTableViewCellID", for: indexPath) as! FYYaoQiSmallIconTableViewCell
        cell.setupUI(modelArr: model.comics! as NSArray)
        return cell
    }
    
    //MARK:懒加载一个tableview
    lazy var tableView = {() -> UITableView in
        let tableView = UITableView.init(frame:CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height - self.mTabbarHeight), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(UINib.init(nibName: "FYYaoQiBigIconTableViewCell", bundle: nil), forCellReuseIdentifier: "FYYaoQiBigIconTableViewCellID")
        tableView.register(FYYaoQiSmallIconTableViewCell.self, forCellReuseIdentifier: "FYYaoQiSmallIconTableViewCellID")
         tableView.register(FYYaoQiCateTableViewCell.self, forCellReuseIdentifier: "FYYaoQiCateTableViewCellID")
        
         self.bannerView = SDCycleScrollView.init(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 200), delegate: self, placeholderImage: UIImage.init(named: ""))
        tableView.tableHeaderView = bannerView
        
        return tableView
    }()
    
    //有几组
    lazy var sectionsArrM = {() -> NSMutableArray in
        let arrm = NSMutableArray()
        return arrm
    }()
    //轮播图
    lazy var bannerM = {() -> NSMutableArray in
        let arrm = NSMutableArray()
        return arrm
    }()
}
