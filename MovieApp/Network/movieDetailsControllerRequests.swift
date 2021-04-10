//
//  movieDetailsControllerRequests.swift
//  MovieApp
//
//  Created by ahmed talaat on 09/04/2021.
//

import Foundation

class movieDetailsControllerRequests: PObject{
    @objc static let shared = movieDetailsControllerRequests()

    func getMovieDetails(movieId:String, success:@escaping (movieModel) -> Void,
                             failure:@escaping ([String:Any]) -> Void){
        let url = "\(baseUrl.baseUrl.rawValue)/movie/\(movieId)?api_key=\(apiKey.value.rawValue)&language=en-US"
        print(url)
        UserServices.shared.serverRequests(url: url) { (results) in
            print(results)
            if let movie = movieModel(fromDictionary: results) as? movieModel{
                success(movie)
            }
        } failure: { (error) in
            failure(error)
        }

    }
}
