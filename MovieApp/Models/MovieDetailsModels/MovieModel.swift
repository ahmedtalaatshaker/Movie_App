//
//  MovieModel.swift
//  MovieApp
//
//  Created by ahmed talaat on 09/04/2021.
//

import Foundation

class movieModel : NSObject, NSCoding{
    
    var genres : [movieGeners]!
    var id :Int!
    var original_language :String!
    var original_title :String!
    var overview :String!
    var poster_path :String!
    var title :String!
    var vote_average :Double!
    var vote_count :Int!
    
    init(fromDictionary dictionary: [String:Any]){
        genres = [movieGeners]()
        if let genresArray = dictionary["genres"] as? [[String:Any]]{
            for dic in genresArray{
                let value = movieGeners(fromDictionary: dic)
                genres.append(value)
            }
        }
        id = dictionary["id"] as? Int
        original_language = dictionary["original_language"] as? String
        original_title = dictionary["original_title"] as? String
        overview = dictionary["overview"] as? String
        poster_path = dictionary["poster_path"] as? String
        title = dictionary["title"] as? String
        vote_average = dictionary["vote_average"] as? Double
        vote_count = dictionary["vote_count"] as? Int
    }
    
    func toDictionary() -> [String:Any]{
        var dictionary = [String:Any]()
        if genres != nil{
            var dictionaryElements = [[String:Any]]()
            for movie in genres {
                dictionaryElements.append(movie.toDictionary())
            }
            dictionary["genres"] = dictionaryElements
        }
        
        if id != nil{
            dictionary["id"] = id
        }
        if original_language != nil{
            dictionary["original_language"] = original_language
        }
        if original_title != nil{
            dictionary["original_title"] = original_title
        }
        if overview != nil{
            dictionary["overview"] = overview
        }
        if poster_path != nil{
            dictionary["poster_path"] = poster_path
        }
        if title != nil{
            dictionary["title"] = title
        }
        if vote_average != nil{
            dictionary["vote_average"] = vote_average
        }
        if vote_count != nil{
            dictionary["vote_count"] = vote_count
        }
        return dictionary
    }

    func encode(with coder: NSCoder) {
        
    }
    
    required init?(coder: NSCoder) {
        
    }
    
}

