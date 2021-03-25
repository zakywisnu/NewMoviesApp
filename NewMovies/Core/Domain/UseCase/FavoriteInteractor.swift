//
//  FavoriteInteractor.swift
//  NewMovies
//
//  Created by Ahmad Zaky on 15/02/21.
//

import Foundation
import RxSwift

protocol FavoriteUseCase {
    func getFavoriteMovie() -> Observable<[MovieModel]>
}

class FavoriteInteractor: FavoriteUseCase {
    private let repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavoriteMovie() -> Observable<[MovieModel]> {
        return repository.getFavoriteMovies()
    }
    
}
