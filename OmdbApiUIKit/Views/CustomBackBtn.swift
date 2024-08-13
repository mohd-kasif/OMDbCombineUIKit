//
//  CustomBackBtn.swift
//  OmdbApiUIKit
//
//  Created by Mohd Kashif on 12/08/24.
//

import Foundation
import UIKit

class CustomBackBtn:UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(imageName:String){
        super.init(frame: .zero)
        configuration?.image=UIImage(systemName: imageName)
        setImage(UIImage(systemName: imageName), for: .normal)
        setupUI()
    }
    
    func setupUI(){
        backgroundColor = .white.withAlphaComponent(0.8)
        tintColor = .label
        frame=CGRect(x: 0, y: 0, width: 30, height: 30)
        layer.cornerRadius=15
        tintColor = .black
        clipsToBounds=true
    }
}
