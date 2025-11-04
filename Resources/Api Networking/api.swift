//
//  SignInVC.swift
//  BMV
//
//  Created by Silstone on 05/09/19.
//  Copyright © 2019 Silstone. All rights reserved.
//

import Foundation
import Alamofire
import iProgressHUD

class HttpClientApi: NSObject{
    
    //MARK: POST API
//    func callPostApi(apiFor:String,parameters:[String:Any],completionHandler: @escaping (_ response: DataResponse<Any>) -> Void)  {
//
//        let headers: HTTPHeaders = [
//            "Content-Type": "application/x-www-form-urlencoded",
//           "Accept": "application/json"
//            ]
//        guard let serviceUrl = URL(string:"\(kBaseUrl)\(apiFor)") else { return }
//        Alamofire.request(serviceUrl,method: .post,parameters: parameters,encoding: URLEncoding.default,headers: headers).responseJSON { (response)  in
//            completionHandler(response)
//        }
//    }
    
        func callPostJsonApi(apiFor:String,parameters:String,completionHandler: @escaping (_ response: DataResponse<Any>) -> Void)  {
            
            let headers: HTTPHeaders = [
                "Content-Type": "application/x-www-form-urlencoded",
               "Accept": "application/json"
                ]
            let originalString = "\(kBaseUrl)\(apiFor)?\(parameters)"
            let urlString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            guard let serviceUrl = URL(string:urlString) else { return }
            
            Alamofire.request(serviceUrl,method: .post,encoding: URLEncoding.default,headers: headers).responseJSON { (response)  in
                completionHandler(response)
                
    //            if response.result.isSuccess {
    //                 completionHandler(response)
    //            } else if response.error?._code == NSURLErrorNotConnectedToInternet{
    //                print(response)
    //            }
            }
        }
    
    func callPostApi(apiFor:String,parameters:String,completionHandler: @escaping (_ response: DataResponse<Any>) -> Void)  {
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
           "Accept": "application/json"
            ]
        let originalString = "\(kBaseUrl)\(apiFor)?\(parameters)"
        guard let serviceUrl = URL(string:originalString) else { return }
        
        Alamofire.request(serviceUrl,method: .post,encoding: URLEncoding.default,headers: headers).responseJSON { (response)  in
            completionHandler(response)
            
//            if response.result.isSuccess {
//                 completionHandler(response)
//            } else if response.error?._code == NSURLErrorNotConnectedToInternet{
//                print(response)
//            }
        }
    }
    
    //MARK: GET API
    func callGetApi(apiFor:String,parameters:String,completionHandler: @escaping (_ response: DataResponse<Any>) -> Void)  {

        let originalString = "\(kBaseUrl)\(apiFor)?\(parameters)"
        let urlString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let serviceUrl = URL(string:originalString) else { return }
        Alamofire.request(serviceUrl, method: .get, encoding: JSONEncoding.prettyPrinted).responseJSON { (response) in
           completionHandler(response)
//            if response.result.isSuccess {
//                 completionHandler(response)
//            } else if response.error?._code == NSURLErrorNotConnectedToInternet{
//                print(response)
//            }
        }
    }
}
