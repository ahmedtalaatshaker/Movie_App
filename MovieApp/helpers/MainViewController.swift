//
//  MainViewController.swift
//  MovieApp
//
//  Created by ahmed talaat on 09/04/2021.
//

import Foundation
import UIKit
import MBProgressHUD
import RealmSwift

class mainViewController :UIViewController{
    let screenWidth = UIScreen.main.bounds.width
    
    func removeAllMovieViews(movieStack:UIStackView){
        for movieView in movieStack.arrangedSubviews{
            movieView.removeFromSuperview()
        }
    }
    
    func updateViewWithLikedIcon(movieStack:UIStackView){
        for vi in movieStack.subviews {
            let movView = vi as! MovieView
            let movieObject = movView.getMovie
            if realmDB.shared.allSavedMovies.first(where: {$0.id == movieObject?.id}) != nil {
                movView.setLiked = "y"
            }else{
                movView.setLiked = "n"
            }
        }
    }
    
    func alert(message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func keyboardWillShow(notification :Notification, scroll: UIScrollView) {
        guard let userInfo = notification.userInfo,
              let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height , right: 0)
        scroll.contentInset = contentInset
    }
    
    func keyboardWillHide(notification : Notification, scroll: UIScrollView){
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scroll.contentInset = contentInset
    }
    
    func removeObserver(scroll: UIScrollView) {
        NotificationCenter.default.removeObserver(self)
    }
    
    func addAbserver(scroll: UIScrollView)  {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) {
            notification in
            self.keyboardWillShow(notification : notification, scroll: scroll)
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) {
            notification in
            self.keyboardWillHide(notification : notification, scroll: scroll)
        }
    }
    
    func showActivityIndicator(lableText :String = "Loading...",hideBackground:Bool = false) {
        let spinner = MBProgressHUD.showAdded(to: self.view, animated: true)
        spinner.isUserInteractionEnabled = true
        spinner.label.text = lableText
        
        spinner.bezelView.style = MBProgressHUDBackgroundStyle.solidColor
        spinner.bezelView.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        spinner.label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        if hideBackground {
            spinner.backgroundColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 0)
            
        }else{
            spinner.backgroundColor = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 0.8594285103)
            
        }
        spinner.activityIndicatorColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func hideActivityIndicator() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}
