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
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    init(vm: MovieListViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
        getMoviewList()
        setupUI()
        configSearchBar()
    }
    
    func getMoviewList(){
        vm.$isLoading
            .receive(on: DispatchQueue.main)
            .sink {[weak self] val in
                guard let self=self else {return}
                if val{
                    self.tableView.reloadData()
                }
            }.store(in: &cancellable)
    }
    
    private func setupUI(){
        tableView.register(CardViewContoller.self, forCellReuseIdentifier: CardViewContoller.reuseID)
        navigationController?.toolbar.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func configSearchBar(){
        let searchBar=UISearchController()
        searchBar.searchBar.backgroundColor = .systemBackground
        searchBar.searchBar.tintColor = .systemCyan
        searchBar.searchBar.placeholder="Enter movie name"
        searchBar.searchResultsUpdater=self
        navigationItem.searchController=searchBar
        
    }
}


extension ViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell=tableView.dequeueReusableCell(withIdentifier: CardViewContoller.reuseID, for: indexPath) as? CardViewContoller else {fatalError("error in showig cell")}
        let movie=vm.movies[indexPath.row]
        cell.configureCell(name: movie.title, year: movie.year, images: movie.poster)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie=vm.movies[indexPath.row]
        let view=UINavigationController(rootViewController: MovieDetailVC(imdb: movie.imdbID))
        present(view, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY=scrollView.contentOffset.y
        let contentHeight=scrollView.contentSize.height
        let height=scrollView.frame.size.height
        
        if offsetY>contentHeight-height{
            vm.loadMoreMovies()
        }
    }
    
}

extension ViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searctString=searchController.searchBar.text else {return}
        vm.setSearchText(searctString)
    }
}
