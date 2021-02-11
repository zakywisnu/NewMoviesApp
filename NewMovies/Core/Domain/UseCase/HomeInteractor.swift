//
//  HomeInteractor.swift
//  NewMovies
//
//  Created by Ahmad Zaky on 01/02/21.
//

import Foundation
import RxSwift

protocol HomeUseCase {
    func getMovies() -> Observable<[MovieModel]>
}

class HomeInteractor: HomeUseCase {
    
    private let repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol){
        self.repository = repository
    }
    
    func getMovies() -> Observable<[MovieModel]> {
        return repository.getMovies()
    }
    
}
