//
//  MovieListView.swift
//  MoviesSwiftUIDemo
//
//  Created by Chirag Gujarati on 04/09/24.
//

import SwiftUI
import Kingfisher

struct MovieListView: View {
    var columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
    var movies: [Movie] = []
    @State var searchText = ""

    var searchedMovies: [Movie] {
        if searchText.isEmpty {
            return movies
        } else {
            return movies.filter { movie in
                movie.title?.lowercased().contains(searchText.lowercased()) ?? false
            }
        }
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(searchedMovies) { movie in
                    NavigationLink(value: movie) {
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
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
    }
}

#Preview {
    MovieListView()
}
