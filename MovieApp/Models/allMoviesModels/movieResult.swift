//
//  movieResult.swift
//  MovieApp
//
//  Created by ahmed talaat on 09/04/2021.
//

import Foundation

class movieResult : NSObject, NSCoding{
    
    var adult : Int!
    var backdrop_path : String!
    var genre_ids : [Int]!
    var id :Int!
    var original_language :String!
    var original_title :String!
    var overview :String!
    var popularity :Double!
    var poster_path :String!
    var release_date :String!
    var title :String!
    var video :Int!
    var vote_average :Double!
    var vote_count :Int!
    
    init(fromDictionary dictionary: [String:Any]){
        adult = dictionary["adult"] as? Int
        backdrop_path = dictionary["backdrop_path"] as? String
        genre_ids = dictionary["genre_ids"] as? [Int]
        id = dictionary["id"] as? Int
        original_language = dictionary["original_language"] as? String
        original_title = dictionary["original_title"] as? String
        overview = dictionary["overview"] as? String
        popularity = Double(round(10*(dictionary["popularity"] as? Double ?? 0.0)) / 10)
        poster_path = dictionary["poster_path"] as? String
        release_date = dictionary["release_date"] as? String
        title = dictionary["title"] as? String
        video = dictionary["video"] as? Int
        vote_average = dictionary["vote_average"] as? Double
        vote_count = dictionary["vote_count"] as? Int
    }
    
    func toDictionary() -> [String:Any]{
        var dictionary = [String:Any]()
        if adult != nil{
            dictionary["adult"] = adult
        }
        if backdrop_path != nil{
            dictionary["backdrop_path"] = backdrop_path
        }
        
        if genre_ids != nil{
            dictionary["genre_ids"] = genre_ids
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
        if popularity != nil{
            dictionary["popularity"] = popularity
        }
        if poster_path != nil{
            dictionary["poster_path"] = poster_path
        }
        if release_date != nil{
            dictionary["release_date"] = release_date
        }
        if title != nil{
            dictionary["title"] = title
        }
        
        if video != nil{
            dictionary["video"] = video
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

