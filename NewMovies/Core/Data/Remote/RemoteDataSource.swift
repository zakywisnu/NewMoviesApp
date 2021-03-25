//
//  RemoteDataSource.swift
//  NewMovies
//
//  Created by Ahmad Zaky on 01/02/21.
//

import Foundation
import RxSwift
import Alamofire

protocol RemoteDataSourceProtocol: class {
    func getMovieList() -> Observable<[MovieResponse]>
    func getMovieDetail(id: Int) -> Observable<MovieResponse>
}

final class RemoteDataSource: NSObject {
    private override init(){}
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getMovieDetail(id: Int) -> Observable<MovieResponse> {
        return Observable<MovieResponse>.create{ observer in
            if let url = URL(string: Endpoints.Gets.detailMovie(id: id).url){
                AF.request(url)
                    .validate()
                    .responseDecodable(of: MovieResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            observer.onNext(value)
                            observer.onCompleted()
                        case .failure:
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }
    
    func getMovieList() -> Observable<[MovieResponse]> {
        return Observable<[MovieResponse]>.create{ observer in
            if let url = URL(string: Endpoints.Gets.popular.url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: MovieListResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            observer.onNext(value.results)
                            observer.onCompleted()
                        case .failure:
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }
}
