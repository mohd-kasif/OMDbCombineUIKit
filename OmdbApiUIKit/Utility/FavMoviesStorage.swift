//
//  FavMoviesStorage.swift
//  OmdbApiUIKit
//
//  Created by Mohd Kashif on 13/08/24.
//

import Foundation
enum FavType{
    case add, delete
}

enum Keys{
    static let fav="Favorites"
}
struct FavMoviesStorage{
    static private let defaults=UserDefaults.standard
    
    
    static func updateWith(favorite:FavModel, type:FavType, completion:@escaping (OMDBError?)->Void){
        retrieve { result in
            switch result {
            case .success(let favList):
                var myFav=favList
                switch type {
                case .add:
                    guard !myFav.contains(favorite) else {
                        completion(.alreadyExist)
                        return
                    }
                    myFav.append(favorite)
                case .delete:
                    myFav.removeAll { val in
                        val.imdbID==favorite.imdbID
                    }
                }
                completion(save(favorites: myFav))
            case .failure(_):
                completion(.invalidData)
            }
        }
    }
    
    static func retrieve(completion:@escaping (Result<[FavModel], OMDBError>)->Void){
        guard let fav=defaults.object(forKey: Keys.fav) as? Data else {
            completion(.success([]))
            return
        }
        
        do{
            let decoded=try JSONDecoder().decode([FavModel].self, from: fav)
            completion(.success(decoded))
            return
        } catch {
            completion(.failure(.invalidData))
        }
    }
    
    static func save(favorites:[FavModel])->OMDBError?{
        do{
            let decoded=try JSONEncoder().encode(favorites)
            defaults.setValue(decoded, forKey: Keys.fav)
            return nil
        }
        catch {
            return .invalidData
        }
    }
}
