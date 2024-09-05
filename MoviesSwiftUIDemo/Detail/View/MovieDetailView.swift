//
//  MovieDetailView.swift
//  MoviesSwiftUIDemo
//
//  Created by Chirag Gujarati on 05/09/24.
//

import SwiftUI
import Kingfisher
import SwiftData

struct MovieDetailView: View {
    @ObservedObject var movieDetailViewModel: MovieDetailViewModel

    init(movieDetailViewModel: MovieDetailViewModel) {
        self.movieDetailViewModel = movieDetailViewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                KFImage(movieDetailViewModel.movieDetail?.posterURL)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Movie:")
                            .fontWeight(.bold)
                        Text("\(movieDetailViewModel.movieDetail?.title ?? "")")
                            .multilineTextAlignment(.leading)
                    }
                    
                    HStack {
                        Text("Description:")
                            .fontWeight(.bold)
                        Text("\(movieDetailViewModel.movieDetail?.tagline ?? "")")
                            .multilineTextAlignment(.leading)
                    }
                    
                    HStack {
                        Text("Duration:")
                            .fontWeight(.bold)
                        Text("\(movieDetailViewModel.movieDetail?.runtime ?? 0) Mins")
                            .multilineTextAlignment(.leading)
                    }
                    
                    HStack {
                        Text("Genres:")
                            .fontWeight(.bold)
                        Text("\(movieDetailViewModel.movieDetail?.genres?.map { $0.name }.joined(separator: ", ") ?? "No Genres")")
                            .multilineTextAlignment(.leading)
                    }
                    
                    Text("Movie is \(movieDetailViewModel.movieDetail?.status ?? "Not released yet").")
                        .multilineTextAlignment(.leading)
                    
                    HStack {
                        Text("Release Date:")
                            .fontWeight(.bold)
                        Text("\(movieDetailViewModel.movieDetail?.releaseDate ?? "")")
                            .multilineTextAlignment(.leading)
                    }
                }
                .padding(.horizontal, 10)
                
                Spacer()
            }
        }
        .navigationTitle(movieDetailViewModel.movieDetail?.title ?? "Details")
        .onAppear(perform: {
            movieDetailViewModel.getMovieDetails()
        })
        .toolbar {
            Button(action: {
                movieDetailViewModel.setFavourite()
            }) {
                if movieDetailViewModel.isLiked == true {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 10)
                        .foregroundColor(.red)
                } else {
                    Image(systemName: "heart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 10)
                        .foregroundColor(.blue)
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
    
    
}
