//
//  MoviesSwiftUIDemoApp.swift
//  MoviesSwiftUIDemo
//
//  Created by Chirag Gujarati on 03/09/24.
//

import SwiftUI
import SwiftData

@main
struct MoviesSwiftUIDemoApp: App {
    let modelContainer: ModelContainer

    init() {
        do {
            modelContainer = try ModelContainer(for: MovieDataModel.self, MovieDetailModel.self, GenreModel.self, FavoriteMovieModel.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView(homeViewModel: HomeViewModel(modelContext: modelContainer.mainContext))
                .modelContainer(modelContainer)
        }
    }
}
