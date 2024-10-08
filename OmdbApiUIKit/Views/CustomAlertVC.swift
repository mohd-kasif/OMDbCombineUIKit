//
//  CustomAlertVC.swift
//  OmdbApiUIKit
//
//  Created by Mohd Kashif on 14/08/24.
//

import Foundation

//
//  CustomAlert.swift
//  GithubSearch
//
//  Created by Mohd Kashif on 06/08/24.
//

import UIKit

class CustomAlert: UIViewController {
    
    let uiView=UIView()
    let titleLable=OMDBTitleLabel(alignement: .center, fontSize: 20)
    let bodyLabel=OMDBBodyLabel(alignement: .center)
    let button=OMDBButton(title: "Ok")
//    let button=GithubButton(title: "Ok", color: .systemPink, image: SFSymbol.checkMark)
    
    var alertTitle:String?
    var message:String?
    var buttonTitle:String?
    
    let padding:CGFloat=20
    
    init(alertTitle: String, message: String, buttonTitle: String) {
        self.alertTitle = alertTitle
        self.message = message
        self.buttonTitle = buttonTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        
    }
    
    private func setupUI(){
        view.addSubview(uiView)
        uiView.layer.cornerRadius=16
        uiView.layer.borderWidth=2
        uiView.layer.borderColor=UIColor.white.cgColor
        uiView.translatesAutoresizingMaskIntoConstraints=false
        uiView.backgroundColor = .systemBackground
        
        uiView.addSubview(titleLable)
        titleLable.text=alertTitle ?? "Somethig went wrong"
        uiView.addSubview(bodyLabel)
        bodyLabel.text=message ?? "Unable to complete request"
        bodyLabel.numberOfLines=4
        
        uiView.addSubview(button)
        
        button.setTitle(buttonTitle ?? "Ok", for: .normal)
        button.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        
        
        // constraints
        
        NSLayoutConstraint.activate([
            uiView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            uiView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uiView.heightAnchor.constraint(equalToConstant: 220),
            uiView.widthAnchor.constraint(equalToConstant: 280),
            
            titleLable.topAnchor.constraint(equalTo: uiView.topAnchor, constant: padding),
            titleLable.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: padding),
            titleLable.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -padding),
            titleLable.heightAnchor.constraint(equalToConstant: 28),
            
            bodyLabel.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 8),
            bodyLabel.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: padding),
            bodyLabel.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -padding),
            
            button.bottomAnchor.constraint(equalTo: uiView.bottomAnchor, constant: -padding),
            button.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: padding),
            button.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -padding),
            button.heightAnchor.constraint(equalToConstant: 44)
            
            
            
        ])
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }

}


class OMDBButton:UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title:String){
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setupUI()
    }
    
    func setupUI(){
        layer.cornerRadius=10
        layer.borderWidth=1
        backgroundColor = .systemPink
        titleLabel?.textColor = .white
        titleLabel?.font=UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints=false
    }
}
