//
//  allMovies.swift
//  MovieApp
//
//  Created by ahmed talaat on 09/04/2021.
//

import Foundation

class movies : NSObject, NSCoding{
    var total_results : Int!
    var total_pages : Int!
    var page : Int!
    var results : [movieResult]!
    
    
    init(fromDictionary dictionary: [String:Any]){
        total_results = dictionary["total_results"] as? Int
        total_pages = dictionary["total_pages"] as? Int
        page = dictionary["page"] as? Int
        
        results = [movieResult]()
        if let resultsArray = dictionary["results"] as? [[String:Any]]{
            for dic in resultsArray{
                let value = movieResult(fromDictionary: dic)
                results.append(value)
            }
        }
    }
    
    func toDictionary() -> [String:Any]{
        var dictionary = [String:Any]()
        if total_results != nil{
            dictionary["total_results"] = total_results
        }
        if total_pages != nil{
            dictionary["total_pages"] = total_pages
        }
        
        if page != nil{
            dictionary["page"] = page
        }
        if results != nil{
            dictionary["results"] = results
        }
        
        if results != nil{
            var dictionaryElements = [[String:Any]]()
            for movie in results {
                dictionaryElements.append(movie.toDictionary())
            }
            dictionary["results"] = dictionaryElements
        }
        
        
        return dictionary
    }

    func encode(with coder: NSCoder) {
        
    }
    
    required init?(coder: NSCoder) {
        
    }
    
    
}
