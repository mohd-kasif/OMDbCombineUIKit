//
//  FavoriteVC.swift
//  OmdbApiUIKit
//
//  Created by Mohd Kashif on 12/08/24.
//

import UIKit

class FavoriteVC: UIViewController {
    var favList:[FavModel]=[]
    var imageView=OMDBImage(frame: .zero)
    let tableView=UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        retriveFav()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        retriveFav()
    }
    func retriveFav(){
        FavMoviesStorage.retrieve {[weak self] result in
            guard let self=self else {return}
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.favList=success
                    self.tableView.reloadData()
                    print(self.favList,"fav list")
                }
            case .failure(let failure):
                print(failure, "failure")
            }
        }
    }
    
    func setupUI(){
        tableView.frame=view.bounds
        tableView.dataSource=self
        tableView.delegate=self
        tableView.translatesAutoresizingMaskIntoConstraints=false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .systemBackground
        view.addSubview(tableView)
    }

}

extension FavoriteVC:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item=favList[indexPath.row]
        var config=cell.defaultContentConfiguration()
        config.imageProperties.maximumSize=CGSize(width: 50, height: 50)
        config.imageProperties.cornerRadius=10
        imageView.returnImage(url: item.url) { image in
            guard let image else {return}
            DispatchQueue.main.async {
                config.text=item.name
                config.secondaryText=item.director
                config.image=image
                cell.contentConfiguration=config
            }
        }


        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favList.count
    }
    
    
}
