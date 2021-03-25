//
//  HomeView.swift
//  NewMovies
//
//  Created by Ahmad Zaky on 01/02/21.
//

import SwiftUI

struct HomeView: View {
    
    @Namespace var namespace
    @State var selectedItem: MovieModel? = nil
    @State var isDisabled = false
    @State var show = false
    
    @ObservedObject var presenter: HomePresenter
    
    var body: some View {
        
        ZStack {
            if presenter.isLoading {
                loadingIndicator
            } else if presenter.isError {
                errorIndicator
            } else if presenter.movies.isEmpty {
                emptyIndicator
            } else {
                ScrollView(.vertical,showsIndicators: false) {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))], spacing: 10) {
                        ForEach(self.presenter.movies, id: \.id) { item in
                            VStack {
                                MovieRow(movie: item)
                                    .matchedGeometryEffect(id: item.id, in: namespace, isSource: !show)
                                    .onTapGesture {
                                        withAnimation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0)) {
                                            show.toggle()
                                            selectedItem = item
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                isDisabled = true
                                            }
                                        }
                                    }
                                    .disabled(isDisabled)
                            }
                            .matchedGeometryEffect(id: "container\(item.id)", in: namespace, isSource: !show)
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity)
                }
                .zIndex(1)
                
                if selectedItem != nil {
                    ZStack(alignment: .topTrailing){
                        MovieDetail(movie: selectedItem!, namespace: namespace)
                        
                        CloseButton()
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    show.toggle()
                                    selectedItem = nil
                                    isDisabled = false
                                }
                            }
                            .padding(.trailing, 20)
                    }
                    .zIndex(2)
                }
            }
        }.onAppear {
            if self.presenter.movies.count == 0 {
                self.presenter.getMovies()
            }
        }
        .navigationBarHidden(show)
        .navigationBarTitle(
            Text("Popular Movies"),displayMode: .automatic
        )
        
    }
}

extension HomeView {
    var loadingIndicator: some View {
        LoadingView()
    }
    var errorIndicator: some View {
        CustomEmptyView(image: "movie_icon", title: presenter.errorMessages)
    }
    
    var emptyIndicator: some View {
        CustomEmptyView(image: "empty_favorite", title: "The Movie Favorite is Empty")
    }
    
//    var content: some View {
//        ScrollView(.vertical,showsIndicators: false) {
//            LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))], spacing: 10) {
//                ForEach(self.presenter.movies, id: \.id) { item in
//                    self.presenter.linkBuilder(for: item){
//                        MovieList(movie: item)
//                    }
//                }
//            }
//        }
//    }
//    var content: some View {
//        ScrollView(.vertical,showsIndicators: false) {
//            LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))], spacing: 10) {
//                ForEach(self.presenter.movies, id: \.id) { item in
//                    VStack {
//                        MovieRow(movie: item)
//                            .matchedGeometryEffect(id: item.id, in: namespace, isSource: !show)
//                            .onTapGesture {
//                                withAnimation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0)) {
//                                    show.toggle()
//                                    selectedItem = item
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                                        isDisabled = true
//                                    }
//                                }
//                            }
//                            .disabled(isDisabled)
//                    }
//                    .matchedGeometryEffect(id: "container\(item.id)", in: namespace, isSource: !show)
//                }
//            }
//            .padding(16)
//            .frame(maxWidth: .infinity)
//        }
//        .zIndex(1)
//
//        if selectedItem != nil {
//            ZStack(alignment: .topTrailing){
//                MovieDetail(movie: selectedItem!, namespace: namespace)
//            }
//            .zIndex(2)
//        }
//    }
}
