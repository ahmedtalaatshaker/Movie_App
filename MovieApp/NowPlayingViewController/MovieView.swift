//
//  MovieView.swift
//  MovieApp
//
//  Created by ahmed talaat on 09/04/2021.
//

import UIKit

import UIKit
import Kingfisher

protocol MovieViewDelegate {
    func MovieTabbed(_ MovieView: MovieView)
    func likeMovieTabbed(_ MovieView: MovieView)
}

class MovieView: UIView {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var votePercent: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var isLiked: UIButton!
    @IBOutlet weak var voteView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    var delegate :MovieViewDelegate!
    var movie : movieResult!
    var liked = "n"
    
    @IBInspectable var setMovie: movieResult? {
        didSet {
            movie = setMovie
            
            movieImage.kf.setImage(with: URL(string: "\(imageBaseUrl.baseUrl.rawValue)\(imageSize.size.rawValue)\(movie.poster_path ?? "")"))
            
            votePercent.text = "\(Int(10 * ( movie.vote_average ?? 0.0)))"
            movieTitle.text = movie.title
        }
    }
    
    @IBInspectable var getMovie: movieResult? {
        get {
            return movie
        }
    }
        
    @IBInspectable var setLiked: String? {
        didSet {
            if setLiked == "y"{
                isLiked.setImage(#imageLiteral(resourceName: "heart-2"), for: .normal)
            }else{
                isLiked.setImage(#imageLiteral(resourceName: "like"), for: .normal)
            }
            liked = setLiked!
        }
    }
    
    @IBInspectable var getLiked: String? {
        get {
            return liked
        }
    }
    
    
    @IBAction func openMovie(_ sender: Any) {
        delegate.MovieTabbed(self)
    }
    
    @IBAction func likeMovie(_ sender: Any) {
        delegate.likeMovieTabbed(self)
    }
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
        
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    func commonInit() {
        
        guard let view = Bundle(for: type(of: self)).loadNibNamed("MovieView", owner: self, options: nil)?.first as? UIView else {
            return
        }
        
        frame = view.bounds
        
        self.addSubview(view)
        
        initUi()
    }
    
    
    fileprivate func initUi() {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = false
        self.layer.shadowColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 8
        voteView.layer.cornerRadius = 20
        containerView.layer.cornerRadius = 10
    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

