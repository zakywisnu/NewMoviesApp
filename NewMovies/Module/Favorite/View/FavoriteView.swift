//
//  FavoriteView.swift
//  NewMovies
//
//  Created by Ahmad Zaky on 15/02/21.
//

import SwiftUI

struct FavoriteView: View {
    
    @ObservedObject var presenter: FavoritePresenter
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                loadingIndicator
            } else if presenter.isError {
                errorIndicator
            } else if presenter.movie.isEmpty {
                emptyIndicator
            } else {
                content
            }
        }.onAppear{
            self.presenter.getFavoriteMovie()
        }
        .navigationBarTitle(
            Text("Favorite Movies"), displayMode: .automatic
        )
    }
}

extension FavoriteView {
    var loadingIndicator: some View {
        LoadingView()
    }
    var errorIndicator: some View {
        CustomEmptyView(image: "movie_icon", title: presenter.errorMessages)
    }
    
    var emptyIndicator: some View {
        CustomEmptyView(image: "empty_favorite", title: "The Movie Favorite is Empty")
    }
    
    var content: some View {
        ScrollView(.vertical,showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(self.presenter.movie, id: \.id) { item in
                    ZStack {
                        self.presenter.linkBuilder(for: item){
                            MovieList(movie: item)
                        }
                    }
                }
            }
        }
    }
}
