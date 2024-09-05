//
//  MovieListViewModel.swift
//  MoviesSwiftUIDemo
//
//  Created by Chirag Gujarati on 05/09/24.
//

import Foundation
import SwiftData

@MainActor
class MovieListViewModel: ObservableObject {
    private let movieService: MovieService
    @Published var modelContext: ModelContext
    @Published var movies: [MovieDataModel]
    @Published var searchText = ""
    @Published var movieSectionList: [MovieDetailModel]

    var searchedMovies: [MovieDataModel] {
        if searchText.isEmpty {
            return movies
        } else {
            return movies.filter { movie in
                movie.title?.lowercased().contains(searchText.lowercased()) ?? false
            }
        }
    }
    
    init(movieService: MovieService = MovieService(), modelContext: ModelContext, movies: [MovieDataModel] = [], searchText: String = "", movieSectionList: [MovieDetailModel] = []) {
        self.movieService = movieService
        self.modelContext = modelContext
        self.movies = movies
        self.searchText = searchText
        self.movieSectionList = movieSectionList
    }
    
    func getMovieDetailById(id: Int) async -> MovieDetailResponse? {
        let request = MovieRequest(dict: [:], id: id)
        
        let result = await movieService.getMovieDetail(request: request)
        switch result {
        case .success(let detail):
            return detail
        case .failure(let error):
            debugPrint(error)
        }
        
        return nil
    }
    
    func saveMovieDetails() async {
        movies.forEach { movie in
            Task {
                if let detail = await getMovieDetailById(id: movie.id ?? 0) {
                    let genreModels = detail.genres?.map { GenreModel(movieId: detail.id, id: $0.id, name: $0.name) }
                    modelContext.insert(MovieDetailModel(id: detail.id, adult: detail.adult, backdropPath: detail.backdropPath, budget: detail.budget, genres: genreModels, homepage: detail.homepage, imdbId: detail.imdbId, originCountry: detail.originCountry, originalLanguage: detail.originalLanguage, originalTitle: detail.originalTitle, overview: detail.overview, popularity: detail.popularity, posterPath: detail.posterPath, releaseDate: detail.releaseDate, revenue: detail.revenue, runtime: detail.runtime, status: detail.status, tagline: detail.tagline, title: detail.title, video: detail.video, voteAverage: detail.voteAverage, voteCount: detail.voteCount, movieType: movies.first?.movieType))
                }
            }
        }
    }
    
    func getMovieDetails()  {
        do {
            let descriptor = FetchDescriptor<MovieDetailModel>()
            movieSectionList = try modelContext.fetch(descriptor)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}
