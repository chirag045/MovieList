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
    //@Environment(\.modelContext) private var modelContext
    @ObservedObject private var homeViewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                Group {
                    if homeViewModel.trendingMovies != nil {
                        MovieImageView(title: HomeMovieType.trending.description, movies: homeViewModel.trendingMovies!)
                    } else {
                        loaderView()
                    }
                }
                .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                
                Group {
                    if homeViewModel.upcomingMovies != nil {
                        MovieImageView(title: HomeMovieType.upcoming.description, movies: homeViewModel.upcomingMovies!)
                    } else {
                        loaderView()
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                
                Group {
                    if homeViewModel.topRatedmovies != nil {
                        MovieImageView(title: HomeMovieType.topRated.description, movies: homeViewModel.topRatedmovies!)
                    } else {
                        loaderView()
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                
                Group {
                    if homeViewModel.popularMovies != nil {
                        MovieImageView(title: HomeMovieType.popular.description, movies: homeViewModel.popularMovies!)
                    } else {
                        loaderView()
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0))
            }
            .navigationTitle("Movies")
        }
        .task {
            await homeViewModel.getTrendingMovies()
            await homeViewModel.getPopularMovies()
            await homeViewModel.getUpcomingMovies()
            await homeViewModel.getTopRatedMovies()
        }
    }
    
    func loaderView() -> some View {
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }
}

#Preview {
    HomeView()
        //.modelContainer(for: Item.self, inMemory: true)
}

struct MovieImageView: View {
    let title: String?
    let movies: [Movie]
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
                        MovieListView(movies: movies)
                    }
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 10) {
                    ForEach(self.movies) { movie in
                        NavigationLink(destination: EmptyView()) {
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
