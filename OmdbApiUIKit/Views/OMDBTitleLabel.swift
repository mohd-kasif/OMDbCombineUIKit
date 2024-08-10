//
//  OMDBTitleLabel.swift
//  OmdbApiUIKit
//
//  Created by Mohd Kashif on 10/08/24.
//

import UIKit

class OMDBTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(alignement:NSTextAlignment, fontSize:CGFloat){
        super.init(frame: .zero)
        textAlignment=alignement
        font=UIFont.systemFont(ofSize: fontSize, weight: .bold)
        setupUI()
    }
    
    func setupUI(){
        textColor = .label
        adjustsFontSizeToFitWidth=true
        minimumScaleFactor=0.8
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints=false
    }
}
