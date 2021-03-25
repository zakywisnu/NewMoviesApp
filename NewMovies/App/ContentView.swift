//
//  ContentView.swift
//  NewMovies
//
//  Created by Ahmad Zaky on 01/02/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var homePresenter: HomePresenter
    @ObservedObject var favoritePresenter: FavoritePresenter
    var body: some View {
        TabView {
            NavigationView{
                HomeView(presenter: homePresenter).environmentObject(homePresenter)
            }.tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            
            NavigationView{
                FavoriteView(presenter: favoritePresenter).environmentObject(favoritePresenter)
            }.tabItem {
                Image(systemName: "heart")
                Text("Favorite")
            }
            
            NavigationView{
                ProfileView()
            }.tabItem {
                Image(systemName: "person")
                Text("Profile")
            }
        }
    }
}
