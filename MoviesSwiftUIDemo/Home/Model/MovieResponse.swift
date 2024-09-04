//
//  Item.swift
//  MoviesSwiftUIDemo
//
//  Created by Chirag Gujarati on 03/09/24.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]?
    let page: Int?
}

struct Movie: Decodable, Identifiable, Hashable {
    let id: Int?
    let adult: Bool?
    let backdropPath: String?
    let genreIds: [Int]?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    var backdropURL: URL? {
        guard let backdropPath = backdropPath else { return nil }
        return URL(string: "\(Constants.baseImageURL)\(backdropPath)")
    }
    
    var posterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "\(Constants.baseImageURL)\(posterPath)")
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self,
                                           forKey: .id)
        adult = try container.decodeIfPresent(Bool.self, forKey:
                .adult)
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        genreIds = try container.decodeIfPresent([Int].self, forKey: .genreIDS)
        
        originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage)
        originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle)
        
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        popularity = try container.decodeIfPresent(Double.self, forKey: .popularity)
        posterPath = try container.decodeIfPresent(String.self,
                                                   forKey: .posterPath)
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        video = try container.decodeIfPresent(Bool.self, forKey:
                .video)
        voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage)
        voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount)
        
    }
}
