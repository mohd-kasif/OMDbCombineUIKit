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
    let movieName=OMDBTitleLabel(alignement: .left, fontSize: 20)
    let imdbRating=OMDBBodyLabel(alignement: .right)
    let movieLabel=LabelView(frame: .zero)

    let starImage=UIImageView()
    
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
        view.addSubview(uiView)
        uiView.backgroundColor = .systemBackground
        uiView.translatesAutoresizingMaskIntoConstraints=false
        uiView.layer.cornerRadius=20
        uiView.addSubview(movieName)
        uiView.addSubview(imdbRating)
        uiView.addSubview(starImage)
        uiView.addSubview(movieLabel)
        
        starImage.translatesAutoresizingMaskIntoConstraints=false
        starImage.tintColor = .systemYellow
        starImage.image=UIImage(systemName: "star.fill")
        
        //constraint
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: 200),

            uiView.topAnchor.constraint(equalTo: image.bottomAnchor, constant: -30),
            uiView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            uiView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            uiView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            uiView.heightAnchor.constraint(equalTo: image.heightAnchor, multiplier: 1.5),

            movieName.topAnchor.constraint(equalTo: uiView.topAnchor, constant: 20),
            movieName.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),
            
            imdbRating.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -30),
            imdbRating.centerYAnchor.constraint(equalTo: movieName.centerYAnchor),
            movieName.trailingAnchor.constraint(lessThanOrEqualTo: imdbRating.leadingAnchor, constant: -10),
            
            starImage.centerYAnchor.constraint(equalTo: movieName.centerYAnchor),
            starImage.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -10),
            starImage.heightAnchor.constraint(equalToConstant: 15),
            starImage.widthAnchor.constraint(equalToConstant: 15),
            
            movieLabel.topAnchor.constraint(equalTo: movieName.topAnchor, constant: 40),
            movieLabel.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 10),
            movieLabel.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -10)
            
            
            
        ])
    }
    
    func configUIElements(withDetail detail:MovieDetailModel){
        self.image.downloadImage(url: detail.poster)
        self.movieName.text=detail.title
        self.imdbRating.text=detail.imdbRating
        self.movieLabel.config(runningTime: detail.runtime, year: detail.year, genre: detail.genre)
    }
    
  
}

