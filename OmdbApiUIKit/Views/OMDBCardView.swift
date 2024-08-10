//
//  OMDBCardView.swift
//  OmdbApiUIKit
//
//  Created by Mohd Kashif on 10/08/24.
//

import UIKit

class OMDBCardView: UIView {
    let imageView=OMDBImage(frame: .zero)
    let movieTitle=OMDBTitleLabel(alignement: .left, fontSize: 20)
    let movieYear=OMDBBodyLabel(alignement: .left)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        translatesAutoresizingMaskIntoConstraints=false
        layer.cornerRadius=8
        layer.borderWidth=2
        backgroundColor = .systemBackground
        layer.shadowColor=UIColor.black.cgColor
        layer.shadowOpacity=0.1
        layer.shadowOffset=CGSize(width: 2, height: 3)
        layer.shadowRadius=10
        layer.borderColor=UIColor.darkGray.withAlphaComponent(0.3).cgColor
        
        
        addSubview(imageView)
        addSubview(movieTitle)
        addSubview(movieYear)
        
        //constraint
        let padding:CGFloat=20
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            imageView.heightAnchor.constraint(equalToConstant: 120),
            imageView.widthAnchor.constraint(equalToConstant: 75),
            
            
            movieTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            movieTitle.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: padding),
            movieTitle.heightAnchor.constraint(equalToConstant: 24),
            movieTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            
            movieYear.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 8),
            movieYear.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: padding),
            movieYear.heightAnchor.constraint(equalToConstant: 20),
            movieYear.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding)
            
        ])
    }

}
