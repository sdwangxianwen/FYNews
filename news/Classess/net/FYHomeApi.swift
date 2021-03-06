//
//  FYHomeApi.swift
//  news
//
//  Created by wang on 2018/9/10.
//  Copyright © 2018年 wang. All rights reserved.
//

import Foundation
import Moya
import MBProgressHUD

public enum HomeAPI {
    case zhiList //智库的列表
    case kankanList(NSInteger)  //看看漫画的列表,有可变参数的时候,比如下拉刷新的pagenum的变化
    case douyuHotList //斗鱼的热门推荐
    case imageUrl //图片列表
    case yqshopList //有妖气书架
    
}

extension HomeAPI : TargetType {
    
    //服务器地址
    public var baseURL: URL {
        switch self {
        case .zhiList:
            return URL(string: "http://47.104.79.197:8080")!
        case .kankanList:
            return URL(string: "https://api.kkmh.com/")!
        case.douyuHotList:
            return URL(string: "http://appi.51kt.com/")!
        case .imageUrl:
            return URL(string: "https://open.adnonstop.com/")!
        case .yqshopList:
             return URL(string: "http://app.u17.com/")!
        }
        
    }
    
    //各个请求的具体路径
    public var path: String {
        switch self {
        case .zhiList:
            return "/newsapi/Server/microText/listMicroText.do"
        case .kankanList:
            return "v1/daily/comic_lists/0"
        case .douyuHotList:
            return "client/Course/getTabList"
        case .imageUrl:
            return "camhomme/biz/prod/api/public/index.php"
        case .yqshopList:
            return "v3/appV3_3/ios/phone/comic/getDetectList"
        }
    }
    
    //请求类型
    public var method: Moya.Method {
        switch self {
        case .zhiList:
            return .post
        case .kankanList:
            return .get
        case .douyuHotList:
            return .get
        case .imageUrl:
            return .get
        case .yqshopList:
            return .get
        }
    }
    
    //请求任务事件（这里附带上参数),想想如果接口多的话,这里会是多么壮观
    public var task: Task {
        var params: [String: Any] = [:]
        switch self {
        case .zhiList:
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        case .kankanList(let pagenum):
            params["gender"] = 1
            params["since"] = pagenum
            params["new_device"] = false
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        case .douyuHotList:
    
            params["appVer"] = "2.9.11"
            params["channel"] = "AppStore"
            params["customString"] = ""
            params["deviceId"] = "e46a6715da4045898a3f6f00807642df"
            params["deviceType"] = "iPhone"
            params["page"] = 1
            params["pagesize"] = 20
            params["phoneType"] = "ios"
            params["sign"] = "b98857f8955d9d84c1a158665e34fc1c"
            params["start_num"] = 0
            params["systemVer"] = "11.4"
            params["tabType"] = "openCourse"
            params["token"] = "10890147_f3c741fa9d3b7b74c6b32d42850f049a"
            params["userId"] = "10890147"
            
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
//            https://open.adnonstop.com/camhomme/biz/prod/api/public/index.php?r=ContentCenter/List&req=eyJpc19lbmMiOjAsImN0aW1lIjoxNTM3MjYxNDQ4LjA3ODkxODksIm9zX3R5cGUiOiJpb3MiLCJkZXZpY2UiOiJpUGhvbmVfOF9QbHVzIiwiaW1laSI6IkVFNDVEM0E3LTNERDktNDE0Ny04NjIxLTlGRDQ2QkM5QjEwRCIsInZlcnNpb24iOiIzLjAuMCIsInBhcmFtIjp7InR5cGUiOjEsInBhZ2Vfc2l6ZSI6MTAsInBhZ2UiOjF9LCJhcHBfbmFtZSI6ImNhbWhvbW1lX2lwaG9uZSIsInNpZ25fY29kZSI6IjZiYjA4ZTFhZmQ4YWFkNjhlOWUifQ%3D%3D
        case .imageUrl:
            params["r"] = "ContentCenter/List"
            params["req"] = "eyJpc19lbmMiOjAsImN0aW1lIjoxNTM3MjYxNDQ4LjA3ODkxODksIm9zX3R5cGUiOiJpb3MiLCJkZXZpY2UiOiJpUGhvbmVfOF9QbHVzIiwiaW1laSI6IkVFNDVEM0E3LTNERDktNDE0Ny04NjIxLTlGRDQ2QkM5QjEwRCIsInZlcnNpb24iOiIzLjAuMCIsInBhcmFtIjp7InR5cGUiOjEsInBhZ2Vfc2l6ZSI6MTAsInBhZ2UiOjF9LCJhcHBfbmFtZSI6ImNhbWhvbW1lX2lwaG9uZSIsInNpZ25fY29kZSI6IjZiYjA4ZTFhZmQ4YWFkNjhlOWUifQ%3D%3D"
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        case .yqshopList:
//            ?device_id=46AC4F00-AC4A-4621-AE8F-0979DBA898E5&likeCate=&model=iPhone%208%20Plus&sexType=3&systemVersion=12.0&target=U17_3.0&time=1537349113&v=3361000&version=4.2.2
            params["device_id"] = "46AC4F00-AC4A-4621-AE8F-0979DBA898E5"
            params["likeCate"] = ""
            params["model"] = "iPhone%208%20Plus"
            params["systemVersion"] = "12.0"
            params["target"] = "U17_3.0"
            params["time"] = 1537349113
            params["v"] = "3361000"
            params["version"] = "4.2.2"
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        }
    }
    //是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    //请求头
    public var headers: [String : String]? {
        return nil
    }
}

// MARK: - 默认的网络提示请求插件
let spinerPlugin = NetworkActivityPlugin { (state,target) in
    if state == .began {
        print("我开始请求")
        MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
    } else {
        print("我结束请求")
        MBProgressHUD.hide(for: UIApplication.shared.keyWindow!, animated: true)
    }
}

// MARK: - 设置请求超时时间
let requestClosure = {(endpoint: Endpoint<HomeAPI>, done: @escaping MoyaProvider<HomeAPI>.RequestResultClosure) in
    do {
        var request: URLRequest = try endpoint.urlRequest()
        request.timeoutInterval = 20    //设置请求超时时间
        done(.success(request))
    } catch  {
        print("错误了 \(error)")
    }
}

// MARK: - 设置请求头部信息
var endpointClosure = { (target: HomeAPI) -> Endpoint<HomeAPI> in
    let sessionId =  ""
    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
    var endpoint: Endpoint = Endpoint<HomeAPI>(
        url: url,
        sampleResponseClosure: {.networkResponse(200, target.sampleData)},
        method: target.method,
        task: target.task,
        httpHeaderFields: target.headers
    )
    return endpoint.adding(newHTTPHeaderFields: [
        "Content-Type" : "application/x-www-form-urlencoded",
        "COOKIE" : "JSESSIONID=\(sessionId)",
        "Accept": "application/json;application/octet-stream;text/html,text/json;text/plain;text/javascript;text/xml;application/x-www-form-urlencoded;image/png;image/jpeg;image/jpg;image/gif;image/bmp;image/*"
        ])
    
}

