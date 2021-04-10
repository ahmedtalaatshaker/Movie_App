//
//  TopRatedControllerRequests.swift
//  MovieApp
//
//  Created by ahmed talaat on 09/04/2021.
//

import Foundation
class topRatedControllerRequests: PObject{
    @objc static let shared = topRatedControllerRequests()

    func getTopRated(page:Int, success:@escaping (movies) -> Void,
                             failure:@escaping ([String:Any]) -> Void){
        let url = "\(baseUrl.baseUrl.rawValue)/movie/top_rated?api_key=\(apiKey.value.rawValue)&language=en-US&page=\(page)"
        print(url)
        UserServices.shared.serverRequests(url: url) { (results) in
            print(results)
            if let movie = movies(fromDictionary: results) as? movies{
                success(movie)
            }
        } failure: { (error) in
            failure(error)
        }

    }
}
