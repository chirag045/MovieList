//
//  MovieDetailModel.swift
//  MoviesSwiftUIDemo
//
//  Created by Chirag Gujarati on 05/09/24.
//

import Foundation
import SwiftData

@Model
class MovieDetailModel {
    @Attribute(.unique) let id: Int?
    let adult: Bool?
    let backdropPath: String?
    let budget: Int?
    var genres: [GenreModel]?
    let homepage: String?
    let imdbId: String?
    let originCountry: [String]?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let revenue: Int?
    let runtime: Int?
    let status: String?
    let tagline: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let movieType: String?

    var backdropURL: URL? {
        guard let backdropPath = backdropPath else { return nil }
        return URL(string: "\(Constants.baseImageURL)\(backdropPath)")
    }
    
    var posterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "\(Constants.baseImageURL)\(posterPath)")
    }
    
    init(id: Int?, adult: Bool?, backdropPath: String?, budget: Int?, genres: [GenreModel]?, homepage: String?, imdbId: String?, originCountry: [String]?, originalLanguage: String?, originalTitle: String?, overview: String?, popularity: Double?, posterPath: String?, releaseDate: String?, revenue: Int?, runtime: Int?, status: String?, tagline: String?, title: String?, video: Bool?, voteAverage: Double?, voteCount: Int?, movieType: String?) {
        self.id = id
        self.adult = adult
        self.backdropPath = backdropPath
        self.budget = budget
        self.genres = genres
        self.homepage = homepage
        self.imdbId = imdbId
        self.originCountry = originCountry
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.revenue = revenue
        self.runtime = runtime
        self.status = status
        self.tagline = tagline
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.movieType = movieType
    }
}

@Model
class GenreModel {
    @Attribute(.unique) let movieId: Int?
    let id: Int?
    let name: String
    var student: MovieDetailModel?

    init(movieId: Int?, id: Int?, name: String, student: MovieDetailModel? = nil) {
        self.movieId = movieId
        self.id = id
        self.name = name
        self.student = student
    }
}
