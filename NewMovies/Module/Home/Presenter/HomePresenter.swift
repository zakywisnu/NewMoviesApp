//
//  HomePresenter.swift
//  NewMovies
//
//  Created by Ahmad Zaky on 01/02/21.
//

import RxSwift
import SwiftUI

class HomePresenter: ObservableObject{
    private let disposeBag = DisposeBag()
    private let router = HomeRouter()
    private let homeUseCase: HomeUseCase
    
    @Published var movies: [MovieModel] = []
    @Published var movie = MovieModel(
        id: 0,
        title: "",
        posterPath: "",
        voteAverage: 0,
        backdropPath: "",
        overview: "",
        releaseDate: "",
        favorite: false
    )
    @Published var errorMessages: String = ""
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func getMovies() {
        isLoading = true
        homeUseCase.getMovies()
            .observe(on: MainScheduler.instance)
            .subscribe{ result in
                self.movies = result
            } onError: { error in
                self.isError = true
                self.isLoading = false
                self.errorMessages = error.localizedDescription
            } onCompleted: {
                self.isLoading = false
                self.isError = false
            }.disposed(by: disposeBag)
    }
    
    func updateFavoriteMovie(id: Int) {
        homeUseCase.updateFavoriteMovie(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe{ result in
                self.movie = result
            } onError: { error in
                self.errorMessages = error.localizedDescription
            } onCompleted: {
                self.isLoading = false
            }.disposed(by: disposeBag)
    }
    
    func linkBuilder<Content: View>(
        for movie: MovieModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: router.makeDetailView(for: movie)) {
            content()
        }
    }
}
