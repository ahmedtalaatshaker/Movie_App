//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by ahmed talaat on 09/04/2021.
//

import UIKit
import Kingfisher

class MovieDetailsViewController: mainViewController {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var ratingCount: UILabel!
    @IBOutlet weak var ratingAvg: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var geners: UILabel!
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var ImageHeight: NSLayoutConstraint!
    
    var movieId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        rateView.layer.cornerRadius = 29
        ImageHeight.constant = screenWidth * 2/3
        getMovieDetails()
        // Do any additional setup after loading the view.
    }
    
    func getMovieDetails(){
        showActivityIndicator()
        movieDetailsControllerRequests.shared.getMovieDetails(movieId: movieId) { (movie) in
            self.setViewData(movie: movie)
        } failure: { (error) in
            self.hideActivityIndicator()
            self.alert(message: error.debugDescription, viewController: self)
        }
    }
    
    func setViewData(movie:movieModel){
        movieImage.kf.setImage(with: URL(string: "\(imageBaseUrl.baseUrl.rawValue)\(imageSize.size.rawValue)\(movie.poster_path ?? "")"))

        movieTitle.text = movie.title
        ratingCount.text = "\(movie.vote_count ?? 0)"
        ratingAvg.text = "\(Int(10 * ( movie.vote_average ?? 0.0)))"
        movieDescription.text = movie.overview
        geners.text = ""
        
        for gen in movie.genres{
            geners.text! += "\(gen.name ?? ""), "
        }
        geners.text?.removeLast(2)
        hideActivityIndicator()
    }

    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
