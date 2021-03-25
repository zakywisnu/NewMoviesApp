//
//  DetailMovieInteractor.swift
//  NewMovies
//
//  Created by Ahmad Zaky on 10/02/21.
//

import Foundation
import RxSwift

protocol DetailUseCase {
    func getMovieDetail() -> Observable<MovieModel>
    func updateFavoriteMovie() -> Observable<MovieModel>
}

class DetailMovieInteractor: DetailUseCase {
    private let repository: MovieRepositoryProtocol
    private let id: Int
    
    required init(by id: Int, repository: MovieRepositoryProtocol){
        self.id = id
        self.repository = repository
    }
    func getMovieDetail() -> Observable<MovieModel> {
        return repository.getMovieDetail(by: id)
    }
    func updateFavoriteMovie() -> Observable<MovieModel> {
        return repository.updateFavoriteMovie(by: id)
    }
}
