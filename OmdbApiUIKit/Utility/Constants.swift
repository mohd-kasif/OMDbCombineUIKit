//
//  Constants.swift
//  OmdbApiUIKit
//
//  Created by Mohd Kashif on 11/08/24.
//

import Foundation

enum EndPoints{
    static let movieDetail="https://www.omdbapi.com/?i=tt2975590&apikey=de089793"
}

enum OMDBError:Error{
    case alreadyExist
    case invalidData
}
