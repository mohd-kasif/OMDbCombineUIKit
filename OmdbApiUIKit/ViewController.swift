//
//  ViewController.swift
//  OmdbApiUIKit
//
//  Created by Mohd Kashif on 16/07/24.
//

import UIKit
import Combine
class ViewController: UIViewController {
    private let vm:MovieListViewModel
    private var cancellable:Set<AnyCancellable>=[]
    init(vm: MovieListViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var seacrhBar: UISearchBar = {
        let search=UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints=false
        search.placeholder="Search.."
        search.delegate=self
        return search
    }()
    
    lazy var tableView:UITableView={
        let table=UITableView()
        table.translatesAutoresizingMaskIntoConstraints=false
        table.separatorStyle=UITableViewCell.SeparatorStyle.none
        table.delegate=self
        table.dataSource=self
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=UIColor.white
        vm.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { val in
                if val{
                    self.tableView.reloadData()
                }
            }
            .store(in: &cancellable)
        setupUI()
    }
    
    private func setupUI(){
        let stack=UIStackView()
        tableView.register(CardViewContoller.self, forCellReuseIdentifier: "Cell")
        stack.translatesAutoresizingMaskIntoConstraints=false
        stack.axis = .vertical
        
        view.addSubview(stack)
        
        //constraint
        stack.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive=true
        stack.widthAnchor.constraint(equalTo: view.widthAnchor).isActive=true
        stack.heightAnchor.constraint(equalTo: view.heightAnchor).isActive=true
        
        stack.addArrangedSubview(seacrhBar)
        stack.addArrangedSubview(tableView)
        
        seacrhBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive=true
        seacrhBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive=true
        seacrhBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive=true
    }


}


extension ViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell=tableView.dequeueReusableCell(withIdentifier: CardViewContoller, for: indexPath) as? CardViewContoller
        guard let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CardViewContoller else {fatalError("error in showig cell")}
        let movie=vm.movies[indexPath.row]
//        var config=cell.defaultContentConfiguration()
//        config.text=movie.title
//        config.secondaryText=movie.year
        if let url=URL(string: movie.poster){
            DispatchQueue.global().async {
                if let data=try? Data(contentsOf: url){
                    DispatchQueue.main.async {
                        let image=UIImage(data: data)
                        if let image=image{
                            cell.configureCell(name: movie.title, year: movie.year, images: image)
                        }
                     
//                        config.image=image
//                        config.imageProperties.maximumSize=CGSize(width: 70, height: 70)
//                        cell.contentConfiguration=config
                    }
                }
            }
        }
        return cell
        
    }
    
    
}

extension ViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        vm.setSearchText(searchText)
    }
}
