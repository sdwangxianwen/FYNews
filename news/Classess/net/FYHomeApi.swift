//
//  FYHomeApi.swift
//  news
//
//  Created by wang on 2018/9/10.
//  Copyright © 2018年 wang. All rights reserved.
//

import Foundation
import Moya

let HomeProvider = MoyaProvider<HomeAPI>()

public enum HomeAPI {
    case zhiList //智库的列表
    case kankanList  //看看漫画的列表    
}

extension HomeAPI : TargetType {
    
    //服务器地址
    public var baseURL: URL {
        switch self {
        case .zhiList:
            return URL(string: "http://47.104.79.197:8080")!
        case .kankanList:
            return URL(string: "https://api.kkmh.com/")!
        }
    }
    
    //各个请求的具体路径
    public var path: String {
        switch self {
        case .zhiList:
            return "/newsapi/Server/microText/listMicroText.do"
        case .kankanList:
            return "v1/daily/comic_lists/0"
        }
    }
    
    //请求类型
    public var method: Moya.Method {
        switch self {
        case .zhiList:
            return .post
        case .kankanList:
            return .get
        }
    }
    
    //请求任务事件（这里附带上参数),想想如果接口多的话,这里会是多么壮观
    public var task: Task {
        switch self {
        case .zhiList:
            var params: [String: Any] = [:]
            params["client_sys"] = "ios"
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        case .kankanList:
            var params: [String: Any] = [:]
            params["gender"] = 1
            params["since"] = 0
            params["new_device"] = false
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
