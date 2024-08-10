//
//  CardViewContoller.swift
//  OmdbApiUIKit
//
//  Created by Mohd Kashif on 21/07/24.
//

import Foundation
import UIKit

class CardViewContoller:UITableViewCell{
    static let reuseID="MovieCell"
    let cardView=OMDBCardView(frame: .zero)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        addSubview(cardView)
        
        //contraint
        
        NSLayoutConstraint.activate([
            
            cardView.topAnchor.constraint(equalTo: self.topAnchor,constant: 8),
            cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            cardView.heightAnchor.constraint(equalToConstant: 140)
                       
        ])
    }
    
    func configureCell(name:String, year:String, images:String){
        cardView.movieTitle.text=name
        cardView.movieYear.text=year
        cardView.imageView.downloadImage(url: images)
        
    }
}

//#Preview{
//    CardViewContoller()
//}
