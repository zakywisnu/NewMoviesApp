//
//  ApiCall.swift
//  NewMovies
//
//  Created by Ahmad Zaky on 01/02/21.
//

import Foundation

struct MovieConstant {
    static let baseURL = "https://api.themoviedb.org/"
    static let apiKey = "c3141d1a29379bd03dceb243cd2a5942"
    static let imageURL = "https://image.tmdb.org/t/p/w500"
}

protocol Endpoint {
    var url: String { get }
}

enum Endpoints {
    enum Gets: Endpoint {
        case popular
        case detailMovie(id: Int)
        
        public var url: String {
            switch self {
            case .popular: return
                "\(MovieConstant.baseURL)3/movie/popular?api_key=\(MovieConstant.apiKey)"
            
            case .detailMovie(let id): return
                "\(MovieConstant.baseURL)3/movie/\(id)?api_key=\(MovieConstant.apiKey)"
            }
        }
    }
}
