//
//  ContentView.swift
//  MoviesSwiftUIDemo
//
//  Created by Chirag Gujarati on 03/09/24.
//

import SwiftUI
import Kingfisher
import SwiftData

struct HomeView: View {
    @ObservedObject private var homeViewModel: HomeViewModel
    
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }
    
    var body: some View {
        NavigationStack {
            if !homeViewModel.isLoading {
                List {
                    Group {
                        if homeViewModel.movies.filter({$0.movieType == HomeMovieType.trending.description}).count > 0 {
                            MovieImageView(title: HomeMovieType.trending.description, movies: homeViewModel.movies.filter({$0.movieType == HomeMovieType.trending.description}), homeViewModel: homeViewModel)
                        } else {
                            Text("No Trending Movies.")
                                .multilineTextAlignment(.center)
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                    
                    Group {
                        if homeViewModel.movies.filter({$0.movieType == HomeMovieType.upcoming.description}).count > 0 {
                            MovieImageView(title: HomeMovieType.upcoming.description, movies: homeViewModel.movies.filter({$0.movieType == HomeMovieType.upcoming.description}), homeViewModel: homeViewModel)
                        } else {
                            Text("No Upcoming Movies.")
                                .multilineTextAlignment(.center)
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    
                    Group {
                        if homeViewModel.movies.filter({$0.movieType == HomeMovieType.topRated.description}).count > 0 {
                            MovieImageView(title: HomeMovieType.topRated.description, movies: homeViewModel.movies.filter({$0.movieType == HomeMovieType.topRated.description}), homeViewModel: homeViewModel)
                        } else {
                            Text("No Top rated Movies.")
                                .multilineTextAlignment(.center)
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                    
                    Group {
                        if homeViewModel.movies.filter({$0.movieType == HomeMovieType.popular.description}).count > 0 {
                            MovieImageView(title: HomeMovieType.popular.description, movies: homeViewModel.movies.filter({$0.movieType == HomeMovieType.popular.description}), homeViewModel: homeViewModel)
                        } else {
                            Text("No Popular Movies.")
                                .multilineTextAlignment(.center)
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0))
                }
                .navigationTitle("Movies")
            } else {
                loaderView()
            }
        }
        .task {
            await homeViewModel.saveMovieToLocal()
            homeViewModel.fetchHomeMovies()
        }
    }
    
    private func loaderView() -> some View {
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }
}


//MARK: - Image View
struct MovieImageView: View {
    let title: String?
    let movies: [MovieDataModel]
    var homeViewModel: HomeViewModel
    @State private var isMoveToDetail = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let title = title {
                HStack {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    Button {
                        isMoveToDetail = true
                    } label: {
                        Text("See All")
                            .fontWeight(.bold)
                    }
                    .padding(.trailing)
                    .navigationDestination(isPresented: $isMoveToDetail) {
                        MovieListView(movieListViewModel: MovieListViewModel(modelContext: homeViewModel.modelContext, movies: movies))
                    }
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 10) {
                    ForEach(movies) { movie in
                        NavigationLink(destination: MovieListView(movieListViewModel: MovieListViewModel(modelContext: homeViewModel.modelContext, movies: movies))) {
                            VStack {
                                KFImage(movie.posterURL)
                                    .resizable()
                                    .frame(width: 160, height: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                                Text(movie.title ?? "")
                                    .lineLimit(2)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 160)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.leading, movie.id == self.movies.first!.id ? 16 : 0)
                        .padding(.trailing, movie.id == self.movies.last!.id ? 16 : 0)
                    }
                }
            }
        }
    }
}
