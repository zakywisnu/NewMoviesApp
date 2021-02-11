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
        
        let locale: LocalDataSource = LocalDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return MovieRepository.sharedInstance(locale,remote)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
}
