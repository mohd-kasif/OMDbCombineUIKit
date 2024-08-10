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
            self?.loadMovies(search: val)
        }.store(in: &cancellable)
    }
    
    func setSearchText(_ searchText:String){
        searchSubject.send(searchText)
    }
    
    func loadMovies(search:String){
        client.fetchMovies(name: search).sink { completion in
            switch completion{
            case .finished:
                self.isLoading=true
            case .failure(let error):
                print(error)
            }
        } receiveValue: {[weak self] movies in
            self?.movies=movies
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
