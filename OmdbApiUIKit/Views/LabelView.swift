//
//  LabelView.swift
//  OmdbApiUIKit
//
//  Created by Mohd Kashif on 12/08/24.
//

import Foundation
import UIKit

class LabelView:UIView{
    let runningTime=MovieLabel(frame: .zero)
    let movieYear=MovieLabel(frame: .zero)
    let genre=MovieLabel(frame: .zero)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI(){
        let padding:CGFloat=5
        addSubview(runningTime)
        addSubview(movieYear)
        addSubview(genre)
        
        //constraint
        translatesAutoresizingMaskIntoConstraints=false
        backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            runningTime.topAnchor.constraint(equalTo: topAnchor),
            runningTime.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            movieYear.centerYAnchor.constraint(equalTo: runningTime.centerYAnchor),
            movieYear.leadingAnchor.constraint(equalTo: runningTime.trailingAnchor, constant: padding),
            movieYear.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            genre.centerYAnchor.constraint(equalTo: movieYear.centerYAnchor),
            genre.leadingAnchor.constraint(equalTo: movieYear.trailingAnchor, constant: padding),
            genre.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
    }
    
    func config(runningTime:String, year:String, genre:String){
                self.runningTime.text=runningTime
                self.movieYear.text=year
                self.genre.text=genre
    }

}

