//
//  SavedMoviesViewController.swift
//  MovieApp
//
//  Created by ahmed talaat on 10/04/2021.
//

import UIKit

class SavedMoviesViewController: mainViewController {

    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var movieStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawMovies(allMovies: realmDB.shared.allSavedMovies)
        // Do any additional setup after loading the view.
    }
    
    func drawMovies(allMovies:[movieResult]){
        for movie in allMovies {
            let movie_view = MovieView()
            movie_view.widthAnchor.constraint(equalToConstant: screenWidth).isActive = true
            movie_view.heightAnchor.constraint(equalToConstant: screenWidth * 2/3).isActive = true

            movie_view.delegate = self
            movie_view.setMovie = movie
            if realmDB.shared.allSavedMovies.first(where: {$0.id == movie.id}) != nil {
                movie_view.setLiked = "y"
            }else{
                movie_view.setLiked = "n"
            }
            
            self.movieStack.addArrangedSubview(movie_view)
        }
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navi  gation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension SavedMoviesViewController:MovieViewDelegate{
    func MovieTabbed(_ MovieView: MovieView) {
        print("MovieTabbed")
        let target = UIStoryboard(name: "MovieDetailsViewController", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        target.movieId = "\(MovieView.getMovie?.id ?? 0)"
        navigationController?.pushViewController(target, animated: true)
    }
    
    func likeMovieTabbed(_ MovieView: MovieView) {
        print("write to db")
        let movie = MovieView.getMovie
        let isLiked = MovieView.getLiked
        if isLiked == "y" {
            realmDB.shared.delete(movieId: movie?.id ?? 0)
            MovieView.setLiked = "n"
        }else{
            realmDB.shared.write(image: movie?.poster_path ?? "", vote: movie?.vote_average ?? 0.0, title: movie?.title ?? "", movieId: movie?.id ?? 0)
            MovieView.setLiked = "y"
        }
        
        realmDB.shared.read()
        
    }
}
