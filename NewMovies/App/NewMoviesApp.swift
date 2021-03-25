//
//  NewMoviesApp.swift
//  NewMovies
//
//  Created by Ahmad Zaky on 01/02/21.
//

import SwiftUI

@main
struct NewMoviesApp: App {
    
    @StateObject var homePresenter = HomePresenter(homeUseCase: Injection().provideHome())
    @StateObject var favoritePresenter = FavoritePresenter(favoriteUseCase: Injection().provideFavorite())
    var body: some Scene {
        WindowGroup {
            ContentView(homePresenter: homePresenter, favoritePresenter: favoritePresenter)
        }
    }
}
