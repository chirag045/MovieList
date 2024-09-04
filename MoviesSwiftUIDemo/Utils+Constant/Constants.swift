//
//  Constants.swift
//  MoviesSwiftUIDemo
//
//  Created by Chirag Gujarati on 03/09/24.
//

import Foundation

let urlSession = URLSession.shared

struct Constants {
    static let apiKey = "170e7a868f7801e1310246e0b4699267"
    static let baseAPIURL = "https://api.themoviedb.org/3/"
    static let baseImageURL = "https://image.tmdb.org/t/p/w500/"
}

enum CommonError: Error {
    case failedToLoad
}

enum HomeMovieType: String, CaseIterable{
    case trending = "trending/movie/day"
    case popular = "movie/popular"
    case upcoming = "movie/upcoming"
    case topRated = "movie/top_rated"
    
    var description: String {
        switch self {
            case .trending: return "Trending"
            case .upcoming: return "Upcoming"
            case .topRated: return "Top Rated"
            case .popular: return "Popular"
        }
    }
}

extension Encodable {
    var dict : [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else { return nil }
        return json
    }
}

func queryString(dictionary: [String:Any]?) -> String {
    guard let dictionary = dictionary else { return "" }
    let queryString = "?"
    let mappedString = dictionary.compactMap({ key, value in
        "\(key)=\(value)"
    }).joined(separator: "&")
    return  queryString + mappedString
}
