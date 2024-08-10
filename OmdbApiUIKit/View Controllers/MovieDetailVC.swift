//
//  MovieDetailVC.swift
//  OmdbApiUIKit
//
//  Created by Mohd Kashif on 11/08/24.
//

import UIKit
import Combine
class MovieDetailVC: UIViewController {
    // Properties

    var vm=MovieListViewModel(client: NetworkClient())
    let backBtn=CustomBackBtn(imageName: "arrow.left")
    let addFavorite=CustomBackBtn(imageName: "suit.heart")
    let shareBtn=CustomBackBtn(imageName: "square.and.arrow.up")
    var image=OMDBImage(frame: .zero)
    let movieName=OMDBTitleLabel(alignement: .center, fontSize: 20)
    let uiView=UIView()
    private var cancellable:Set<AnyCancellable>=[]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItems=[UIBarButtonItem(customView: backBtn)]
        backBtn.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        let btn1=UIBarButtonItem(customView: addFavorite)
        let btn2=UIBarButtonItem(customView: shareBtn)
        navigationItem.rightBarButtonItems=[btn2, btn1]

        
        setupUI()
    }
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    init(imdb:String){
        super.init(nibName: nil, bundle: nil)
        vm.fetchMovieDetail(imdbId: imdb)
        vm.$isLoading.sink { val in
            if val{
                self.configUIElements(withDetail: self.vm.movieDetail)
            }
        }
        .store(in: &cancellable)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        view.addSubview(image)
        uiView.backgroundColor = .systemBackground
        uiView.translatesAutoresizingMaskIntoConstraints=false
        image.addSubview(uiView)
        uiView.layer.cornerRadius=20
        uiView.addSubview(movieName)
        
        //constraint
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            uiView.leadingAnchor.constraint(equalTo: image.leadingAnchor),
            uiView.trailingAnchor.constraint(equalTo: image.trailingAnchor),
            uiView.bottomAnchor.constraint(equalTo: image.bottomAnchor),
            uiView.heightAnchor.constraint(equalTo: image.heightAnchor, multiplier: 0.8),
            
            movieName.centerXAnchor.constraint(equalTo: uiView.centerXAnchor),
            movieName.topAnchor.constraint(equalTo: uiView.topAnchor, constant: 20),
            movieName.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),
            movieName.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -10)
        ])
    }
    
    func configUIElements(withDetail detail:MovieDetailModel){
        self.image.downloadImage(url: detail.poster)
        self.movieName.text=detail.title
    }
  
}

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
        backgroundColor = .systemBackground.withAlphaComponent(0.8)
//        configuration?.baseForegroundColor = .white
        tintColor = .label
        frame=CGRect(x: 0, y: 0, width: 30, height: 30)
        layer.cornerRadius=15
        tintColor = .black
        clipsToBounds=true
    }
}
