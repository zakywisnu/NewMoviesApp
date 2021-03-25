//
//  FavoritePresenter.swift
//  NewMovies
//
//  Created by Ahmad Zaky on 15/02/21.
//

import SwiftUI
import RxSwift

class FavoritePresenter: ObservableObject {
    private let disposeBag = DisposeBag()
    private let favoriteUseCase: FavoriteUseCase
    private let router = FavoriteRouter()
    
    init(favoriteUseCase: FavoriteUseCase) {
        self.favoriteUseCase = favoriteUseCase
    }
    
    @Published var movie: [MovieModel] = []
    @Published var errorMessages: String = ""
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    
    func getFavoriteMovie() {
        isLoading = true
        favoriteUseCase.getFavoriteMovie()
            .observe(on: MainScheduler.instance)
            .subscribe{ result in
                self.movie = result
            } onError: { error in
                self.errorMessages = error.localizedDescription
                self.isError = true
                self.isLoading = false
            } onCompleted: {
                self.isLoading = false
                self.isError = false
            }.disposed(by: disposeBag)
    }
    
    func linkBuilder<Content: View> (
        for movie: MovieModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: router.makeDetailView(for: movie)){
            content()
        }
    }
}
