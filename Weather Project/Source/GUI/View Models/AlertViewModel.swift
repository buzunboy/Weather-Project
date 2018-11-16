//
//  AlertViewModel.swift
//  Weather Project
//
//  Created by Burak Uzunboy on 16.11.2018.
//  Copyright © 2018 buzunboy. All rights reserved.
//

import UIKit

/**
 Alert View Model
 - Since: 16.11.2018
 */
public class AlertViewModel {
    
    private init() {
        
    }
    
    public static func showAlertWithoutAction(title: String, subtitle: String? = nil) {
        let alertVC = getAlertVC(title: title, subtitle: subtitle)

        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            rootVC.present(alertVC, animated: true, completion: nil)
        }
    }
    
    public static func showAlert(title: String, subtitle: String? = nil, actions: UIAlertAction...) {
        let alertVC = getAlertVC(title: title, subtitle: subtitle)
        for action in actions {
            alertVC.addAction(action)
        }
        
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            rootVC.present(alertVC, animated: true, completion: nil)
        }
    }
    
    private static func getAlertVC(title: String, subtitle: String?) -> UIAlertController {
        let alertVC = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        
        let cancelAct = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            NSLog("Cancel Action clicked on alert view")
        }
        
        alertVC.addAction(cancelAct)
        return alertVC
    }
    
}
