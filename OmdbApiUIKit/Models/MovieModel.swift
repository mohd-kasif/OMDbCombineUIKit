//
//  MovieModel.swift
//  OmdbApiUIKit
//
//  Created by Mohd Kashif on 16/07/24.
//

import Foundation
/*
 "Title": "Batman Begins",
      "Year": "2005",
      "imdbID": "tt0372784",
      "Type": "movie",
      "Poster": "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg"
 */
struct MovieModel:Codable{
    let Search:[Movie]
}

struct Movie:Codable{
    let title:String
    let year:String
    let imdbID:String
    let type:String
    let poster:String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
