//
//  FYNetManager.swift
//  news
//
//  Created by wang on 2018/9/10.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON
import ObjectMapper

//成功的闭包
typealias SuccessArrModelClosure = (_ result: [Mappable]?)->Void //返回的是数组json
typealias SuccessJSONClosure = (_ result:JSON) -> Void  //返回的是json

//失败的闭包
typealias FailClosure = (_ result : String?) -> Void


class FYNetManager: NSObject {
    static let shared = FYNetManager()
    
    private override init(){}
    private let failInfo = "数据解析失败"
    
    /// 请求JSON数据
    func requestDataWithTargetJSON<T:TargetType>(target : T, successClosure: @escaping SuccessJSONClosure, failClosure: @escaping FailClosure) {
        let requestProvider = MoyaProvider<T>(requestClosure:requestTimeoutClosure(target: target))
        let _ = requestProvider.request(target) { (result) -> () in
            switch result{
            case let .success(response):
                do {
                    let mapjson = try response.mapJSON()
                    let json = JSON(mapjson)
                    guard let _ = json.dictionaryObject else{
                        failClosure(self.failInfo)
                        return
                    }
                    successClosure(json["response"])
                } catch {
                    failClosure(self.failInfo)
                }
            case let .failure(error):
                failClosure(error.errorDescription)
            }
        }
    }
    
    ///设置一个公共请求超时时间
    private func requestTimeoutClosure<T:TargetType>(target:T) -> MoyaProvider<T>.RequestClosure{
        let requestTimeoutClosure = { (endpoint:Endpoint<T>, done: @escaping MoyaProvider<T>.RequestResultClosure) in
            do{
                var request = try endpoint.urlRequest()
                request.timeoutInterval = 20 //设置请求超时时间
                done(.success(request))
            }catch{
                return
            }
        }
        return requestTimeoutClosure
    }
    
}
