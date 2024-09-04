//
//  HomeViewModel.swift
//  MoviesSwiftUIDemo
//
//  Created by Chirag Gujarati on 03/09/24.
//

import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var trendingMovies: [Movie]?
    @Published var popularMovies: [Movie]?
    @Published var upcomingMovies: [Movie]?
    @Published var topRatedmovies: [Movie]?

    private let params = ["page": 1, "language": "en-US"] as [String: Any]
    
    private let homeService: HomeService
    
    init(homeService: HomeService = HomeService()) {
        self.homeService = homeService
    }
    
    func getTrendingMovies() async {
        let request = HomeRequest(dict: params, type: .trending)
        
        let result = await homeService.getMovies(request: request)
        switch result {
        case .success(let movies):
            self.trendingMovies = movies.results
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func getPopularMovies() async {
        let request = HomeRequest(dict: params, type: .popular)
        
        let result = await homeService.getMovies(request: request)
        switch result {
        case .success(let movies):
            self.popularMovies = movies.results
        case .failure(let error):
            debugPrint(error)
        }
    }

    func getUpcomingMovies() async {
        let request = HomeRequest(dict: params, type: .upcoming)
        
        let result = await homeService.getMovies(request: request)
        switch result {
        case .success(let movies):
            self.upcomingMovies = movies.results
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    func getTopRatedMovies() async {
        let request = HomeRequest(dict: params, type: .topRated)
        
        let result = await homeService.getMovies(request: request)
        switch result {
        case .success(let movies):
            self.topRatedmovies = movies.results
        case .failure(let error):
            debugPrint(error)
        }
    }
    
}
