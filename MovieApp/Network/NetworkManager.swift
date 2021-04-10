//
//  NetworkManager.swift
//  MovieApp
//
//  Created by ahmed talaat on 09/04/2021.
//

import Foundation
import Alamofire
//import Localize

@objc class NetworkManager: NSObject {
    
    // MARK: - Properties
    
    let reachabilityManager:NetworkReachabilityManager?
    
    @objc static let sharedInstance = NetworkManager()
    
    // MARK: - Initialization
    
    private override init() {
        
        reachabilityManager = NetworkReachabilityManager(host: "www.google.com")
    }
    
    // MARK: - Accessors
    
    @objc func isConnected() -> Bool {
        return reachabilityManager?.isReachable ?? false
    }
    
    @objc func isConnected3G() -> Bool {
        return reachabilityManager?.isReachableOnWWAN ?? false
    }
    
}
