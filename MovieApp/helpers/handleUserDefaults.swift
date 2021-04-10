//
//  handleUserDefaults.swift
//  MovieApp
//
//  Created by ahmed talaat on 10/04/2021.
//

import Foundation

class userDefaultsHandler : PObject {
    @objc static let shared = userDefaultsHandler()

    func save(value of:String,in key:String){
        UserDefaults.standard.set(of, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func getValue(from:String) -> String{
        return UserDefaults.standard.string(forKey: from) ?? ""
    }
}

