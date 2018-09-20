//
//  FYYaoQiViewController.swift
//  news
//
//  Created by wang on 2018/9/19.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit

class FYYaoQiViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK:隐藏NAV
        navigationController?.setToolbarHidden(true, animated: false)
        netWorking()
        view.addSubview(tableView)
    }
    
    
    func netWorking()  {
        FYNetManager.shared.requestDataWithTargetJSON(target: HomeAPI.yqshopList, successClosure: { (response) in
           print(response)
            //轮播图的网络请求
            let arr = NSArray.yy_modelArray(with: galleryItems.self, json: response["returnData"]["galleryItems"].rawValue) as! [galleryItems]
            self.bannerM.addObjects(from: arr)
            
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
        let model = sectionsArrM[section] as! comicLists
        return model.comics!.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel.init(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 60))
         let model = sectionsArrM[section] as! comicLists
        label.text = model.itemTitle
        label.textAlignment = .center
        label.textColor = UIColor.brown
        return label
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 150
        } else {
            return (self.view.width - 40)/3
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : FYYQTableViewCell?
        cell = (tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FYYQTableViewCell)
        if cell == nil {
            cell = FYYQTableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        let model = sectionsArrM[indexPath.section] as! comicLists
        let comModel = model.comics![indexPath.row]
        print(comModel.name!)
        
        return cell!
        
        
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FYYQTableViewCell
//        let model = sectionsArrM[indexPath.section] as! comicLists
//        let arr = NSArray.yy_modelArray(with: comicsModel.self, json: model.comics) as! [comicsModel]
//        cell.setupUI(isBigIcon: indexPath.row == 0, model:arr[indexPath.row])
//        return cell
    }
    
    //MARK:懒加载一个tableview
    lazy var tableView = {() -> UITableView in
        let tableView = UITableView.init(frame: self.view.frame, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FYYQTableViewCell.self, forCellReuseIdentifier: "cell")
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
