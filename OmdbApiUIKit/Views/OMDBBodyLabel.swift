//
//  OMDBBodyLabel.swift
//  OmdbApiUIKit
//
//  Created by Mohd Kashif on 10/08/24.
//

import UIKit

class OMDBBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(alignement:NSTextAlignment){
        super.init(frame: .zero)
        textAlignment=alignement
        setupUI()
    }
    
    func setupUI(){
        textColor = .label
        adjustsFontSizeToFitWidth=true
        minimumScaleFactor=0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints=false
        font=UIFont.preferredFont(forTextStyle: .body)
    }
}
