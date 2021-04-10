//
//  movieGeners.swift
//  MovieApp
//
//  Created by ahmed talaat on 09/04/2021.
//

import Foundation


class movieGeners : NSObject, NSCoding{
    
    var name : String!
    var id :Int!
   
    init(fromDictionary dictionary: [String:Any]){
        name = dictionary["name"] as? String
        id = dictionary["id"] as? Int
    }
    
    
    func toDictionary() -> [String:Any]{
        var dictionary = [String:Any]()
        if name != nil{
            dictionary["name"] = name
        }
        if id != nil{
            dictionary["id"] = id
        }
        
        return dictionary
    }
    
    
    func encode(with coder: NSCoder) {
        
    }
    
    required init?(coder: NSCoder) {
        
    }
    
}
