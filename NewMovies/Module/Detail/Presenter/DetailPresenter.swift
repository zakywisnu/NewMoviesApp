//
//  DetailPresenter.swift
//  NewMovies
//
//  Created by Ahmad Zaky on 14/02/21.
//

import Foundation
import RxSwift

class DetailPresenter: ObservableObject {
    private let detailUseCase : DetailUseCase
    private let disposable = DisposeBag()
    
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
    @Published var isLoading = false
    @Published var isError = false
    @Published var errorMessage = ""
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
    }
    
    func getMovieDetail() {
        self.isLoading = true
        self.isError = false
        detailUseCase.getMovieDetail()
            .observe(on: MainScheduler.instance)
            .subscribe{ result in
                self.movie = result
            } onError: { Error in
                self.errorMessage = Error.localizedDescription
                self.isError = true
                self.isLoading = false
            } onCompleted: {
                self.isLoading = false
                self.isError = false
            }.disposed(by: disposable)
    }
    
    func updateFavoriteMovie() {
        detailUseCase.updateFavoriteMovie()
            .observe(on: MainScheduler.instance)
            .subscribe{ result in
                self.movie = result
            } onError: { error in
                self.errorMessage = error.localizedDescription
            } onCompleted: {
                self.isLoading = false
            }.disposed(by: disposable
            )
    }
}
