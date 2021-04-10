//
//  NowPlayingControllerRequests.swift
//  MovieApp
//
//  Created by ahmed talaat on 09/04/2021.
//

import Foundation
import UIKit

class nowPlayingControllerRequests: PObject{
    @objc static let shared = nowPlayingControllerRequests()

    func getNowPlayingMovies(page:Int, success:@escaping (movies) -> Void,
                             failure:@escaping ([String:Any]) -> Void){
        let url = "\(baseUrl.baseUrl.rawValue)/movie/now_playing?api_key=\(apiKey.value.rawValue)&language=en-US&page=\(page)"
        print(url)
        UserServices.shared.serverRequests(url: url) { (results) in
            if let allMovies = movies(fromDictionary: results) as? movies{
                success(allMovies)
            }
        } failure: { (error) in
            failure(error)
        }

    }
}
