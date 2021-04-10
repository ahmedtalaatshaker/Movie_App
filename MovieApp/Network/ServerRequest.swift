//
//  ServerRequest.swift
//  MovieApp
//
//  Created by ahmed talaat on 09/04/2021.
//

import Foundation
import Alamofire


class UserServices: PObject {
    
    @objc static let shared = UserServices()
    
    func serverRequests(url :String,
                        method :Alamofire.HTTPMethod = .get,
                        success:@escaping ([String:Any]) -> Void,
                        failure:@escaping ([String:Any]) -> Void ) {
        
        var RequestURL = URL(string: "")
        var newUrl = url.replacingOccurrences(of: " ", with: "")
        newUrl = newUrl.arToEnDigits
        RequestURL = URL(string: newUrl)

        var request = URLRequest(url: RequestURL!)
        request.httpMethod = method.rawValue
        
        Alamofire.request(request).responseData{ response in
            print(response.response?.statusCode)
            print(response.timeline)
            print(response.response)

            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do {
                    let readableJson = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments)
                    if let respoDict = readableJson as? [String:Any] {
                        print(respoDict)
                        success(respoDict)
                    }
                }catch {
                    failure(["msg":"Time Out"])
                }
            }else{
                do {
                    let readableJson = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments)
                    if let respoDict = readableJson as? [String:Any] {
                        print(respoDict)
                        print("❌")
                        failure(respoDict)
                    }
                }catch {
                    print("❌")
                    if !NetworkManager.sharedInstance.isConnected3G() && !NetworkManager.sharedInstance.isConnected() {
                        failure(["msg":"Please Check your internet connection!"])
                    }else{
                        failure(["msg":"Time Out"])
                        
                    }
                }
            }
        }
    }
    
    
}
