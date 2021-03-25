//
//  Injection.swift
//  NewMovies
//
//  Created by Ahmad Zaky on 02/02/21.
//

import Foundation
import RealmSwift

final class Injection : NSObject {
    private func provideRepository() -> MovieRepositoryProtocol {
        let realm = try? Realm()
        
        let local: LocalDataSource = LocalDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return MovieRepository.sharedInstance(local,remote)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideDetail(by id: Int) -> DetailUseCase {
        let repository = provideRepository()
        return DetailMovieInteractor(by: id, repository: repository)
    }
    
    func provideFavorite() -> FavoriteUseCase {
        let repository = provideRepository()
        return FavoriteInteractor(repository: repository)
    }
    
}
