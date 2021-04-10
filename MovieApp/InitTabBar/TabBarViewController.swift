//
//  TabBarViewController.swift
//  MovieApp
//
//  Created by ahmed talaat on 09/04/2021.
//

import UIKit
import ESTabBarController_swift

class TabBarViewController: ESTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let NowPlayingStoryboard = UIStoryboard(name: "nowPlayingViewController", bundle: nil)
        let TopRatedStoryboard = UIStoryboard(name: "TopRatedViewController", bundle: nil)
        let SearchStoryboard = UIStoryboard(name: "SearchViewController", bundle: nil)
        
        let v1 = NowPlayingStoryboard.instantiateViewController(withIdentifier: "nowPlayingViewController")
        let v2 = TopRatedStoryboard.instantiateViewController(withIdentifier: "TopRatedViewController")
        let v3 = SearchStoryboard.instantiateViewController(withIdentifier: "SearchViewController")
        
        v1.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(), title: "Now Playing", image: UIImage(named: "live-streaming-2"), selectedImage: UIImage(named: "live-streaming-2"))
        v2.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(), title: "Top Rated", image: UIImage(named: "top-games-star"), selectedImage: UIImage(named: "top-games-star"))
        v3.tabBarItem = ESTabBarItem.init(ExampleBouncesContentView(), title: "Search", image: UIImage(named: "loupe"), selectedImage: UIImage(named: "loupe"))

        viewControllers = [v1, v2, v3]
        
        // Do any additional setup after loading the view.
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
