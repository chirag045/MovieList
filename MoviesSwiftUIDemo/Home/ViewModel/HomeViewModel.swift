//
//  HomeViewModel.swift
//  MoviesSwiftUIDemo
//
//  Created by Chirag Gujarati on 03/09/24.
//

import Foundation
import SwiftData

@MainActor
class HomeViewModel: ObservableObject {
    @Published var modelContext: ModelContext
    @Published var favoriteMoviesInformation = [FavoriteMovieModel]()
    @Published var movies = [MovieDataModel]()
    @Published var isLoading: Bool = true
    
    private let params = ["page": 1, "language": "en-US"] as [String: Any]
    private let homeService: HomeService
    
    init(homeService: HomeService = HomeService(),
         modelContext: ModelContext) {
        self.homeService = homeService
        self.modelContext = modelContext
    }
    
    func fetchHomeMovies() {
        do {
            let descriptor = FetchDescriptor<MovieDataModel>(sortBy: [SortDescriptor(\MovieDataModel.title)])
            movies = try modelContext.fetch(descriptor)
            isLoading = false
        } catch {
            debugPrint(error.localizedDescription)
            isLoading = false
        }
    }

    func getCategoryMovie(type: HomeMovieType) async -> [Movie] {
        let request = HomeRequest(dict: params, type: type)
        
        let result = await homeService.getMovies(request: request)
        switch result {
        case .success(let movies):
            return movies.results
        case .failure(let error):
            debugPrint(error)
        }
        return []
    }
    
    func saveMovieToLocal() async {
        isLoading = true
        let trending = await getCategoryMovie(type: .trending)
        let popular = await getCategoryMovie(type: .popular)
        let upcoming = await getCategoryMovie(type: .upcoming)
        let topRated = await getCategoryMovie(type: .topRated)

        let group = DispatchGroup()
        if movies.isEmpty {
            trending.forEach { movie in
                group.enter()
                let movies = MovieDataModel(id: movie.id, adult: movie.adult, backdropPath: movie.backdropPath, genreIds: movie.genreIds, originalLanguage: movie.originalLanguage, originalTitle: movie.originalTitle, overview: movie.overview, popularity: movie.popularity, posterPath: movie.posterPath, releaseDate: movie.releaseDate, title: movie.title, video: movie.video, voteAverage: movie.voteAverage, voteCount: movie.voteCount, movieType: HomeMovieType.trending.description)
                modelContext.insert(movies)
                group.leave()
            }
            popular.forEach { movie in
                group.enter()
                let movies = MovieDataModel(id: movie.id, adult: movie.adult, backdropPath: movie.backdropPath, genreIds: movie.genreIds, originalLanguage: movie.originalLanguage, originalTitle: movie.originalTitle, overview: movie.overview, popularity: movie.popularity, posterPath: movie.posterPath, releaseDate: movie.releaseDate, title: movie.title, video: movie.video, voteAverage: movie.voteAverage, voteCount: movie.voteCount, movieType: HomeMovieType.popular.description)
                modelContext.insert(movies)
                group.leave()
            }
            upcoming.forEach { movie in
                group.enter()
                let movies = MovieDataModel(id: movie.id, adult: movie.adult, backdropPath: movie.backdropPath, genreIds: movie.genreIds, originalLanguage: movie.originalLanguage, originalTitle: movie.originalTitle, overview: movie.overview, popularity: movie.popularity, posterPath: movie.posterPath, releaseDate: movie.releaseDate, title: movie.title, video: movie.video, voteAverage: movie.voteAverage, voteCount: movie.voteCount, movieType: HomeMovieType.upcoming.description)
                modelContext.insert(movies)
                group.leave()
            }
            topRated.forEach { movie in
                group.enter()
                let movies = MovieDataModel(id: movie.id, adult: movie.adult, backdropPath: movie.backdropPath, genreIds: movie.genreIds, originalLanguage: movie.originalLanguage, originalTitle: movie.originalTitle, overview: movie.overview, popularity: movie.popularity, posterPath: movie.posterPath, releaseDate: movie.releaseDate, title: movie.title, video: movie.video, voteAverage: movie.voteAverage, voteCount: movie.voteCount, movieType: HomeMovieType.topRated.description)
                modelContext.insert(movies)
                group.leave()
            }
        } else {
            isLoading = false
        }
        
        group.notify(queue: .main) {
            self.isLoading = false
        }
    }
}
