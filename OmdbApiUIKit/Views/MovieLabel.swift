//
//  MovieLabel.swift
//  OmdbApiUIKit
//
//  Created by Mohd Kashif on 12/08/24.
//

import Foundation
import UIKit
class MovieLabel:UILabel{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        layer.cornerRadius=10
        layer.borderWidth=1
        textAlignment = .center
        font=UIFont.systemFont(ofSize: 14, weight: .light)
        backgroundColor = .systemGray4.withAlphaComponent(0.7)
        layer.borderColor = UIColor.black.cgColor
        textColor = .label
        minimumScaleFactor = 0.8
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints=false
        clipsToBounds=true
        numberOfLines=0
    }
    
    override var intrinsicContentSize: CGSize{
        let size = super.intrinsicContentSize
             let adjustedSize = CGSize(width: size.width + 20, height: size.height + 10)
             return adjustedSize
    }
}
