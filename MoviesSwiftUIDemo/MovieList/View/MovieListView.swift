//
//  MovieListView.swift
//  MoviesSwiftUIDemo
//
//  Created by Chirag Gujarati on 04/09/24.
//

import SwiftUI
import Kingfisher
import SwiftData

struct MovieListView: View {
    var columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
    @ObservedObject var movieListViewModel: MovieListViewModel

    init(movieListViewModel: MovieListViewModel) {
        self.movieListViewModel = movieListViewModel
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(movieListViewModel.searchedMovies) { movie in
                    NavigationLink(destination: MovieDetailView(movieDetailViewModel: MovieDetailViewModel(modelContext: movieListViewModel.modelContext, movieDetail: movieListViewModel.movieSectionList.first(where: {$0.id == movie.id})))) {
                        VStack(spacing: 10) {
                            KFImage(movie.posterURL)
                                .resizable()
                                .frame(height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            Text(movie.title ?? "")
                                .lineLimit(1)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 13))
                        }
                        .frame(height: 250)
                    }
                }
            }
            .padding(.horizontal, 10)
            .buttonStyle(PlainButtonStyle())
            .searchable(text: $movieListViewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
        .task {
            await movieListViewModel.saveMovieDetails()
            movieListViewModel.getMovieDetails()
        }
        .navigationTitle(movieListViewModel.movies.first?.movieType?.description ?? "Movies")
    }
}
