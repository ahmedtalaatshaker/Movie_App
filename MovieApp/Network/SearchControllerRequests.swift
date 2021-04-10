//
//  SearchControllerRequests.swift
//  MovieApp
//
//  Created by ahmed talaat on 09/04/2021.
//

import Foundation
class searchControllerRequests: PObject{
    @objc static let shared = searchControllerRequests()

    func getSearchMovie(query:String, page:Int, success:@escaping (movies) -> Void,
                             failure:@escaping ([String:Any]) -> Void){
        let url = "\(baseUrl.baseUrl.rawValue)/search/movie?api_key=\(apiKey.value.rawValue)&language=en-US&query=\(query)&page=\(page)&include_adult=false"
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
