//
//  OMDBImage.swift
//  OmdbApiUIKit
//
//  Created by Mohd Kashif on 10/08/24.
//

import UIKit

class OMDBImage: UIImageView {
    let cache=Singleton.shared.cache
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI(){
        layer.cornerRadius=5
        clipsToBounds=true
        translatesAutoresizingMaskIntoConstraints=false
        image=UIImage(named: "placeholldar-image")
    }

    func downloadImage(url:String){
        if let image=self.cache.object(forKey: url as NSString){
            self.image=image
            return
        }
        
        guard let urlString=URL(string: url) else {
        print("unable to covert url")
            return
        }
        
        let dataTask=URLSession.shared.dataTask(with: urlString){[weak self] data, response, error in
            guard let self=self else {return}
            if error != nil{
                return
            }
            guard let data=data, let response=response as? HTTPURLResponse, response.statusCode==200 else{
                return
            }
            guard let image=UIImage(data: data) else {
                return
            }
            self.cache.setObject(image, forKey: url as NSString)
            DispatchQueue.main.async {
                self.image=image
            }
        }
        dataTask.resume()
    }

}

class Singleton{
    static let shared=Singleton()
    private init(){}
    
    var cache=NSCache<NSString, UIImage>()
}
