//
//  SearchViewController.swift
//  MovieApp
//
//  Created by ahmed talaat on 09/04/2021.
//

import UIKit

class SearchViewController: mainViewController,UISearchBarDelegate,UIScrollViewDelegate {

    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var movieStack: UIStackView!
    var page = 1
    var moreDataExists = true

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        search.delegate = self
        scroll.delegate = self
        
        let lastSearchKeyword = userDefaultsHandler.shared.getValue(from: userDefaultsKeys.lastSearch.rawValue)
        
        if lastSearchKeyword != "" {
            search.text = lastSearchKeyword
            searchForMovie()
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateViewWithLikedIcon(movieStack: movieStack)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        removeAllMovieViews(movieStack: movieStack)
        if search.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
            searchForMovie()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.count == 0 {
            removeAllMovieViews(movieStack: movieStack)
        }
    }
    
    func searchForMovie(){
        moreDataExists = false
        if search.text?.count ?? 0 > 0{
            userDefaultsHandler.shared.save(value: search.text ?? "", in: userDefaultsKeys.lastSearch.rawValue)
        }
        search.resignFirstResponder()
        showActivityIndicator()
        searchControllerRequests.shared.getSearchMovie(query: search.text ?? "", page: page) { (movies) in
            self.page += 1
            self.drawMovies(allMovies: movies)

        } failure: { (error) in
            self.hideActivityIndicator()

            self.alert(message: error.debugDescription, viewController: self)
        }

    }
    
    func drawMovies(allMovies:movies){
        if allMovies.results.count < 20 {
            moreDataExists = false
        }else{
            moreDataExists = true
        }
        
        for movie in allMovies.results {
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
        hideActivityIndicator()

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == scroll && moreDataExists{
            if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
                searchForMovie()
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension SearchViewController:MovieViewDelegate{
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
