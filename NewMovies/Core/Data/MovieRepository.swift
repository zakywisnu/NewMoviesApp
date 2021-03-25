//
//  MovieRepository.swift
//  NewMovies
//
//  Created by Ahmad Zaky on 01/02/21.
//

import Foundation
import RxSwift

protocol MovieRepositoryProtocol {
    func getMovies() -> Observable<[MovieModel]>
    func getMovieDetail(by id: Int) -> Observable<MovieModel>
    func updateFavoriteMovie(by id: Int) -> Observable<MovieModel>
    func getFavoriteMovies() -> Observable<[MovieModel]>
}

final class MovieRepository: NSObject {
    typealias MovieInstance = (LocalDataSource, RemoteDataSource) -> MovieRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let local: LocalDataSource
    
    private init(local: LocalDataSource, remote: RemoteDataSource){
        self.local = local
        self.remote = remote
    }
    
    static let sharedInstance: MovieInstance = { localRepo, remoteRepo in
        return MovieRepository(local: localRepo, remote: remoteRepo)
    }
}

extension MovieRepository: MovieRepositoryProtocol {
    func getFavoriteMovies() -> Observable<[MovieModel]> {
        return self.local.getFavoriteMovies()
            .map{ MovieMapper.mapMovieEntitiesToDomains(input: $0)}
    }
    
    func updateFavoriteMovie(by id: Int) -> Observable<MovieModel> {
        return self.local.updateFavoriteMovies(by: id)
            .map{ MovieMapper.mapMovieEntityToDomain(input: $0)}
    }
    
    func getMovies() -> Observable<[MovieModel]> {
        return self.local.getMovies()
            .map{ MovieMapper.mapMovieEntitiesToDomains(input: $0) }
            .filter{!$0.isEmpty}
            .ifEmpty ( switchTo: self.remote.getMovieList()
                .map{ MovieMapper.mapMovieResponsesToEntities(input: $0) }
                .flatMap{ self.local.addMovies(from: $0)}
                .filter{$0}
                .flatMap{ _ in self.local.getMovies()
                    .map{ MovieMapper.mapMovieEntitiesToDomains(input: $0)}
                }
            )
    }

    func getMovieDetail(by id: Int) -> Observable<MovieModel> {
        return self.local.getDetailMovie(by: id)
            .map{ MovieMapper.mapMovieEntityToDomain(input: $0)}
    }
}
