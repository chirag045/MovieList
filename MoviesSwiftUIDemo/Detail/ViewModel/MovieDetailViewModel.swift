//
//  MovieDetailViewModel.swift
//  MoviesSwiftUIDemo
//
//  Created by Chirag Gujarati on 05/09/24.
//

import Foundation
import SwiftData

class MovieDetailViewModel: ObservableObject {
    @Published var modelContext: ModelContext
    @Published var movieDetail: MovieDetailModel?
    @Published var isLiked: Bool?
    @Published var favoriteMovies: [FavoriteMovieModel]

    init(modelContext: ModelContext, movieDetail: MovieDetailModel?, favoriteMovies: [FavoriteMovieModel] = []) {
        self.modelContext = modelContext
        self.movieDetail = movieDetail
        self.favoriteMovies = favoriteMovies
    }

    func getMovieDetails()  {
        do {
            let descriptor = FetchDescriptor<FavoriteMovieModel>()
            favoriteMovies = try modelContext.fetch(descriptor)
            isLiked = favoriteMovies.filter({$0.id == movieDetail?.id && $0.movieType == movieDetail?.movieType}).count > 0
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func setFavourite() {
        if let objectToDelete = favoriteMovies.first(where: {$0.id == movieDetail?.id && $0.movieType == movieDetail?.movieType} ) {
            modelContext.delete(objectToDelete)
            isLiked = false
        } else {
            let favModel = FavoriteMovieModel(id: movieDetail?.id ?? 1, movieType: movieDetail?.movieType ?? "")
            modelContext.insert(favModel)
            isLiked = true
        }
    }
    
}
