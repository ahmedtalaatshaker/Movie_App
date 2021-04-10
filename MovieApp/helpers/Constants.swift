//
//  Constants.swift
//  MovieApp
//
//  Created by ahmed talaat on 09/04/2021.
//

import Foundation

enum apiKey:String {
    case value = "2eaf425c506c6e4063a47febd3595ab4"
}

enum imageBaseUrl :String {
    case baseUrl = "https://image.tmdb.org/t/p"
}

enum imageSize :String {
    case size = "/w500"
}

enum baseUrl:String {
    case baseUrl = "https://api.themoviedb.org/3"
}

enum userDefaultsKeys:String {
    case lastSearch = "lastSearch"
}
