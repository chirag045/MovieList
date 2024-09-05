//
//  FavoriteMovieModel.swift
//  MoviesSwiftUIDemo
//
//  Created by Chirag Gujarati on 05/09/24.
//

import Foundation
import SwiftData

@Model
class FavoriteMovieModel: Hashable {
    @Attribute(.unique) let id: Int
    var movieType: String

    init(id: Int, movieType: String) {
        self.id = id
        self.movieType = movieType
    }
}
