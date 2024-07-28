//
//  CardViewContoller.swift
//  OmdbApiUIKit
//
//  Created by Mohd Kashif on 21/07/24.
//

import Foundation
import UIKit

class CardViewContoller:UITableViewCell{

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let container:UIView={
        let uiview=UIView()
        uiview.backgroundColor = .cardBackground
        uiview.layer.cornerRadius=10
        uiview.layer.borderWidth=1
        uiview.layer.shadowColor=UIColor.black.cgColor
        uiview.layer.shadowOpacity=0.2
        uiview.layer.shadowOffset=CGSize(width: 2, height: 3)
        uiview.layer.shadowRadius=10
        uiview.layer.borderColor=UIColor.darkGray.withAlphaComponent(0.3).cgColor
        uiview.translatesAutoresizingMaskIntoConstraints=false
    
        return uiview
    }()
    
    let nameLabel:UILabel={
        let label=UILabel()
        label.translatesAutoresizingMaskIntoConstraints=false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        return label
        
    }()
    
    let image:UIImageView={
        let image=UIImageView()
        image.translatesAutoresizingMaskIntoConstraints=false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds=true
        return image
    }()
    let moviewYear:UILabel={
        let label=UILabel()
        label.translatesAutoresizingMaskIntoConstraints=false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    func setupUI(){
        contentView.addSubview(container)
        container.addSubview(image)
        container.addSubview(nameLabel)
        container.addSubview(moviewYear)
        
        //contraint
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 8),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            container.heightAnchor.constraint(equalToConstant: 200),
            
            image.topAnchor.constraint(equalTo: container.topAnchor,constant: 10),
            image.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: image.bottomAnchor,constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor,constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor,constant: -8),
            
            moviewYear.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            moviewYear.leadingAnchor.constraint(equalTo: container.leadingAnchor,constant: 8),
            moviewYear.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),
            moviewYear.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8)
            
        ])
    }
    
    func configureCell(name:String, year:String, images:UIImage){
        image.image=images
        nameLabel.text=name
        moviewYear.text=year
    }

}

//#Preview{
//    CardViewContoller()
//}
