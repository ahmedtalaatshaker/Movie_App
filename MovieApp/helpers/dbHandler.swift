//
//  dbHandler.swift
//  MovieApp
//
//  Created by ahmed talaat on 10/04/2021.
//

import Foundation
import RealmSwift
class movieTable :Object{
    @objc static let shared = movieTable()

    @objc dynamic var movieImage = ""
    @objc dynamic var movieVotePercent = 0.0
    @objc dynamic var movieTitle = ""
    @objc dynamic var movieId = 0

    static func create(image: String,vote: Double,title: String,movieId:Int) -> movieTable {
        let movie = movieTable()
        movie.movieImage = image
        movie.movieVotePercent = vote
        movie.movieTitle = title
        movie.movieId = movieId
        
        return movie
    }
}

protocol handleSavedMoviesIcon_NowPlaying {
    func setSaved(exists:Bool)
}

protocol handleSavedMoviesIcon_TopRated {
    func setSaved(exists:Bool)
}


class realmDB : NSObject{
    var delegate_NowPlaying : handleSavedMoviesIcon_NowPlaying?
    var delegate_TopRated : handleSavedMoviesIcon_TopRated?

    @objc static let shared = realmDB()
    let realm = try! Realm()
    var allSavedMovies = [movieResult]()
    
    func write(image: String,vote: Double,title: String,movieId:Int) {
        let movie = movieTable.create(image: image, vote: vote, title: title,movieId:movieId)
        
        try? realm.write {
            realm.add(movie)
            let movie = movieResult(fromDictionary: [:])
            movie.id = movieId
            movie.title = title
            movie.poster_path = image
            movie.vote_average = vote
            allSavedMovies.append(movie)
        }
        delegate_TopRated?.setSaved(exists: true)
        delegate_NowPlaying?.setSaved(exists: true)

        print(allSavedMovies)
    }
    
    func read() {
        let data = realm.objects(movieTable.self)
        allSavedMovies = []
        for row in data {
            let movie = movieResult(fromDictionary: [:])
            movie.id = row.movieId
            movie.title = row.movieTitle
            movie.poster_path = row.movieImage
            movie.vote_average = row.movieVotePercent
            allSavedMovies.append(movie)
        }
        delegate_TopRated?.setSaved(exists: allSavedMovies.count > 0)
        delegate_NowPlaying?.setSaved(exists: allSavedMovies.count > 0)

        print(data)
    }
    
    func delete(movieId:Int) {
        // Update data
        let data = realm.objects(movieTable.self)
        for row in data {
            if row.movieId == movieId {
                try! realm.write {
                    realm.delete(row)
                }
                break
            }
        }
        allSavedMovies.removeAll{$0.id == movieId}
        print(allSavedMovies)
        delegate_TopRated?.setSaved(exists: allSavedMovies.count > 0)
        delegate_NowPlaying?.setSaved(exists: allSavedMovies.count > 0)
    }
    
}
