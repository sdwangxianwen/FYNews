//
//  FYMeViewController.swift
//  news
//
//  Created by wang on 2018/9/10.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit

class FYMeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    var collectionview : UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        netWorking()
        
    }
    
    func setupUI()  {
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: view.frame.size.width/4 - 5, height: view.frame.size.width/4 - 5)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionview = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        view.addSubview(collectionview)
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.register(FYDouYuCollectionViewCell.self, forCellWithReuseIdentifier: "FYDouYuCollectionViewCellID")
        collectionview.backgroundColor = UIColor.white
        collectionview.alwaysBounceVertical = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrM.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "FYDouYuCollectionViewCellID", for: indexPath) as!FYDouYuCollectionViewCell
        let model = arrM[indexPath.row]
        cell.setModel(model: model as! FYDouYuModel)
        return cell
    }

    
    func netWorking()  {
        FYNetManager.shared.requestDataWithTargetJSON(target: HomeAPI.douyuHotList, successClosure: { (response) in
            print(response)
            let arr = NSArray.yy_modelArray(with: FYDouYuModel.self, json: response["cate2_list"].rawValue) as! [FYDouYuModel]
            self.arrM.addObjects(from: arr)
            self.collectionview.reloadData()
        }) { (error) in
            
        }
    }
    
    //MARK:懒加载
    lazy var arrM  = { () -> NSMutableArray in
        let arrM = NSMutableArray(array: [])
        return arrM
    }()
}
