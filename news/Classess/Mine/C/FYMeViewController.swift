//
//  FYMeViewController.swift
//  news
//
//  Created by wang on 2018/9/10.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit
import YYModel

class FYMeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
   
    var segementControl : UISegmentedControl!
    var listArr : NSArray!
    var tableView : UITableView!
    var offset : CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()
        listArr = NSArray()
        offset = 0
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupUI()
        netWorking()
    }
    
    func setupUI()  {
        segementControl = UISegmentedControl.init(frame: CGRect(x: 10, y: 64, width:self.view.frame.size.width - 20 , height: 44))
        view.addSubview(self.segementControl)
        segementControl.backgroundColor = UIColor().hexStringToColor(hexString: "0x07a2ee")
        segementControl.layer.cornerRadius = 22
        segementControl.clipsToBounds = true
        segementControl.layer.borderColor = UIColor().hexStringToColor(hexString:"0x07a2ee").cgColor
        segementControl.layer.borderWidth = 2
        segementControl.tintColor = UIColor.white
        segementControl.setTitleTextAttributes([:], for: .normal)
        segementControl.setTitleTextAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17),NSAttributedStringKey.foregroundColor : UIColor().hexStringToColor(hexString: "0x07a2ee")], for: .normal)
        
        tableView = UITableView.init(frame: CGRect(x: 0, y: 108, width: view.frame.size.width, height: view.frame.size.height - 108))
        view.addSubview(tableView)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.register(FYImageTableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.estimatedRowHeight = 200
        tableView.rowHeight = 150
        tableView.register(UINib(nibName: "FYMoveImageTableViewCell", bundle: nil), forCellReuseIdentifier: "FYMoveImageTableViewCellID")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArr!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell : FYImageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FYImageTableViewCell
//        cell.model = (listArr![indexPath.row] as! imageList)
//        return cell
       let cell = tableView.dequeueReusableCell(withIdentifier: "FYMoveImageTableViewCellID", for: indexPath) as! FYMoveImageTableViewCell
        cell.model = (listArr![indexPath.row] as! imageList)
        return cell
    }
  
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         // 获取表视图的可见单元格。(可见的视图)
        let arr : [FYMoveImageTableViewCell] = tableView.visibleCells as! [FYMoveImageTableViewCell]
        for cell in arr {
            cell.cellOnTableView(tableView: tableView, view: view)
        }
    }
    

    func netWorking()  {
        FYNetManager.shared.requestDataWithTargetJSON(target: HomeAPI.douyuHotList, successClosure: { (response) in
            print(response)
            
            let arr = NSArray.yy_modelArray(with: tabHorizontalModel.self, json: response["tab"]["tabHorizontal"].rawString() as Any) as! [tabHorizontalModel]
            for index in stride(from: 0, through: arr.count - 1, by: 1) {
                let model = arr[index]
                self.segementControl.insertSegment(withTitle: model.tabName, at: index, animated: false)
                self.segementControl.selectedSegmentIndex = 0
                self.segementControl.addTarget(self, action: #selector(self.segementClick(segement:)), for: .valueChanged)
            }
        }) { (error) in
            
        }
        
        FYNetManager.shared.requestDataWithTargetJSON(target: HomeAPI.imageUrl, successClosure: { (response) in
            print(response)
            self.listArr  = NSArray.yy_modelArray(with: imageList.self, json: response["ret_data"]["list"].rawString() as Any)! as NSArray
        
            self.tableView.reloadData()
        }) { (error) in
            
        }
    }
    @objc func segementClick(segement:UISegmentedControl) {
        print("dianjil")
    }
    
    func listNetWork(tabtype:String) {
        
    }
    
    //MARK:懒加载
    lazy var arrM  = { () -> NSMutableArray in
        let arrM = NSMutableArray(array: [])
        return arrM
    }()
}
