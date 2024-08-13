//
//  MovieListViewModel.swift
//  OmdbApiUIKit
//
//  Created by Mohd Kashif on 16/07/24.
//

import Foundation
import Combine
import UIKit
class MovieListViewModel{
    @Published private(set) var movies:[Movie]=[]
    @Published private(set) var movieDetail:MovieDetailModel=MovieDetailModel(title: "", year: "", rated: "", released: "", runtime: "", genre: "", director: "", writer: "", actors: "", plot: "", language: "", country: "", awards: "", poster: "", metascore: "", imdbRating: "", imdbVotes: "", imdbID: "", type: "",  response: "")
    @Published var isLoading:Bool=false
    private let client:NetworkClient
    var page:Int=1
    private var cancellable:Set<AnyCancellable>=[]
    private var searchSubject=CurrentValueSubject<String,Never>("")
    init(client:NetworkClient) {
        self.client=client
        searchPublisher()
    }
    
    private func searchPublisher(){
        searchSubject
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink {[weak self] val in
                guard let self=self else {return}
                movies.removeAll()
                self.page=1
                self.loadMovies(search: val, page:self.page)
            }.store(in: &cancellable)
    }
    
    func setSearchText(_ searchText:String){
        searchSubject.send(searchText)
    }
    
    func loadMoreMovies(){
//        guard !isLoading else {return}
        page += 1
        loadMovies(search: searchSubject.value, page: page)
    }
    
    func loadMovies(search:String, page:Int){
        client.fetchMovies(name: search, page: page).sink { completion in
            switch completion{
            case .finished:
                self.isLoading=true
            case .failure(let error):
                print(error)
            }
        } receiveValue: {[weak self] movies in
            guard let self=self else {return}
            self.movies.append(contentsOf: movies)
            print(self.movies.count, "movie")
            self.isLoading=false
        }.store(in: &cancellable)

    }
    
    func fetchMovieDetail(imdbId:String){
        client.fetchMoviewDetail(withID: imdbId).sink { completion in
            switch completion{
            case .finished:
                self.isLoading=true
            case .failure(let error):
                print(error, "error in ")
            }
        } receiveValue: { [weak self] detail in
            guard let self=self else {return}
            self.movieDetail=detail
        }.store(in: &cancellable)

    }
}
