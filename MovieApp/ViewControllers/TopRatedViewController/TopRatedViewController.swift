//
//  TopRatedViewController.swift
//  MovieApp
//
//  Created by ahmed talaat on 09/04/2021.
//

import UIKit
import CRRefresh

class TopRatedViewController: mainViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var savedButton: UIButton!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var movieStack: UIStackView!
    var page = 1
    var moreDataExists = true

    override func viewDidLoad() {
        super.viewDidLoad()
        scroll.delegate = self
        realmDB.shared.delegate_TopRated = self
        realmDB.shared.read()
        getTopRated()
        scroll.cr.addHeadRefresh(animator: NormalHeaderAnimator()){
            self.removeAllMovieViews(movieStack: self.movieStack)
            self.page = 1
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (Timer) in
                self.getTopRated(showIndicator:false)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateViewWithLikedIcon(movieStack: movieStack)
    }
    
    func getTopRated(showIndicator:Bool = true){
        moreDataExists = false
        if showIndicator{
            showActivityIndicator()
        }
        topRatedControllerRequests.shared.getTopRated(page: page) { (movies) in
            self.page += 1
            self.drawMovies(allMovies: movies)
            self.scroll.cr.endHeaderRefresh()
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
            movie_view.heightAnchor.constraint(equalToConstant: 200).isActive = true

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
            if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) && scrollView.contentOffset.y > 0 {
                getTopRated()
            }
        }
    }
    
    @IBAction func showSavedMovies(_ sender: Any) {
        if realmDB.shared.allSavedMovies.count > 0 {
            let target = UIStoryboard(name: "SavedMoviesViewController", bundle: nil).instantiateViewController(withIdentifier: "SavedMoviesViewController") as! SavedMoviesViewController
            navigationController?.pushViewController(target, animated: true)
        }else{
            alert(message: "You Didn't Save Any Movies Yet", viewController: self)
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

extension TopRatedViewController:MovieViewDelegate{
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

extension TopRatedViewController:handleSavedMoviesIcon_TopRated{
    func setSaved(exists: Bool) {
        savedButton.setImage( exists ? #imageLiteral(resourceName: "heart-2") : #imageLiteral(resourceName: "like"), for: .normal)
    }
}
