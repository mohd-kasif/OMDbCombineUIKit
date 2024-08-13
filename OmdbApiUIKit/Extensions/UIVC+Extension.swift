//
//  UIVC+Extension.swift
//  OmdbApiUIKit
//
//  Created by Mohd Kashif on 13/08/24.
//

import Foundation
import UIKit
fileprivate var container:UIView!
extension UIViewController{
    func showLoading(){
        container=UIView(frame: view.bounds)
        view.addSubview(container)
        container.backgroundColor = .systemBackground
        container.alpha=0
        UIView.animate(withDuration: 0.25, animations: {
            container.alpha=0.8
        })
        
        let activityIndicator=UIActivityIndicatorView(style: .large)
        container.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints=false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoading(){
        DispatchQueue.main.async {
            container.removeFromSuperview()
            container=nil
        }
    }
    
    func presentAlertVC(title:String, message:String, buttonTitle:String){
        DispatchQueue.main.async {
            let alertVC=CustomAlert(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
