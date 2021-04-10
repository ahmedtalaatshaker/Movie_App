//
//  PObject.swift
//  MovieApp
//
//  Created by ahmed talaat on 09/04/2021.
//

import Foundation
import UIKit

class PObject: NSObject {
    
    func alert(message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func responseDecoder(responseData : Data) -> [String:Any] {
        do {
            let readableJson = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as! [String:Any]
            return readableJson
        }catch {

        }
        return ["DecoderError":"Failed to decode"]
    }
    
    func responseDecoderArrayOfDic(responseData : Data) -> [[String:Any]] {
        do {
            let readableJson = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as! [[String:Any]]
            return readableJson
        }catch {
            
        }
        return [["DecoderError":"Failed to decode"]]
    }
    
}
