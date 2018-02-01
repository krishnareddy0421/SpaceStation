//
//  UIViewController+Extension.swift
//  SpaceStation
//
//  Created by Krishna Kamjula on 23/01/18.
//  Copyright © 2018 Krishna Kamjula. All rights reserved.
//

import UIKit

/**
 * Error Alerts based on the message passed
 */
extension UIViewController{
    
    func showAlert(message:String) {
        
        let alert = UIAlertController(title: NSLocalizedString("Warning!", comment: "Warning title"), message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK title"), style: .default, handler: nil)
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
}
