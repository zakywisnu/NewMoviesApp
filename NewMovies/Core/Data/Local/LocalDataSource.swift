//
//  LocalDataSource.swift
//  NewMovies
//
//  Created by Ahmad Zaky on 01/02/21.
//

import Foundation
import RxSwift
import RealmSwift
import Combine

protocol LocalDataSourceProtocol: class {
    func getMovies() -> Observable<[MovieEntity]>
    func addMovies(from movies: [MovieEntity]) -> Observable<Bool>
    func updateFavoriteMovies(by idMovies: Int) -> Observable<MovieEntity>
    func getDetailMovie(by id: Int) -> Observable<MovieEntity>
    func getFavoriteMovies() -> Observable<[MovieEntity]>
}

final class LocalDataSource: NSObject {
    private let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocalDataSource = { realmDatabase in
        return LocalDataSource(realm: realmDatabase)
    }
}
 


extension LocalDataSource: LocalDataSourceProtocol {
    
    func getFavoriteMovies() -> Observable<[MovieEntity]> {
        return Observable<[MovieEntity]>.create{ observer in
            if let realm = self.realm {
                let movieEntity = {
                    realm.objects(MovieEntity.self)
                        .filter("favorite = \(true)")
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                observer.onNext(movieEntity.toArray(ofType: MovieEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func getMovies() -> Observable<[MovieEntity]> {
        return Observable<[MovieEntity]>.create{ observer in
            if let realm = self.realm {
                let movies: Results<MovieEntity> = {
                    realm.objects(MovieEntity.self)
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                observer.onNext(movies.toArray(ofType: MovieEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func getDetailMovie(by id: Int) -> Observable<MovieEntity> {
        return Observable<MovieEntity>.create{ observer in
            if let realm = self.realm {
                let movies: Results<MovieEntity> = {
                    realm.objects(MovieEntity.self)
                        .filter("id = \(id)")
                }()
                if let movie = movies.first {
                    observer.onNext(movie)
                    observer.onCompleted()
                } else {
                    observer.onError(DatabaseError.requestFailed)
                }
                
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func addMovies(from movies: [MovieEntity]) -> Observable<Bool> {
        return Observable<Bool>.create{ observer in
            if let realm = self.realm {
                do {
                    try realm.write{
                        for movie in movies {
                            realm.add(movie, update: .all)
                        }
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func updateFavoriteMovies(by idMovies: Int) -> Observable<MovieEntity> {
        return Observable<MovieEntity>.create{ observer in
            if let realm = self.realm, let movieEntity =  {
                realm.objects(MovieEntity.self).filter("id = \(idMovies)")
            }().first {
                do {
                    try realm.write{
                        movieEntity.setValue(!movieEntity.favorite, forKey: "favorite")
                    }
                    observer.onNext(movieEntity)
                    observer.onCompleted()
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                } 
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    
    
    
}

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
    
}
