//
//  NetworkClient.swift
//  OmdbApiUIKit
//
//  Created by Mohd Kashif on 16/07/24.
//

import Foundation
import Combine

enum NetworkError:Error{
    case invalidUrl
}

enum APIKey{
    static let apikey="de089793"
}

class NetworkClient{
    
    func fetchMovies(name:String, page:Int)->AnyPublisher<[Movie],Error>{
        guard let encodeSearch=name.urlEncode, let url=URL(string: "https://www.omdbapi.com/?s=\(encodeSearch)&page=\(page)&apikey=\(APIKey.apikey)") else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }
        
         return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MovieModel.self, decoder: JSONDecoder())
            .map(\.Search)
            .receive(on: DispatchQueue.main)
            .catch { error->AnyPublisher<[Movie],Error> in
                return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func fetchMoviewDetail(withID imdbId:String)->AnyPublisher<MovieDetailModel, Error>{
        guard let url=URL(string: "https://www.omdbapi.com/?i=\(imdbId)&apikey=\(APIKey.apikey)") else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MovieDetailModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .catch{error->AnyPublisher<MovieDetailModel, Error> in
                return Fail(error: error).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
