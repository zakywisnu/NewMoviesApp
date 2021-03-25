//
//  MovieModel.swift
//  NewMovies
//
//  Created by Ahmad Zaky on 01/02/21.
//

import Foundation

struct MovieModel: Identifiable, Equatable {
    let id: Int
    let title: String
    var posterPath: String
    var voteAverage: Double
    var backdropPath: String
    var overview: String
    var releaseDate: String
    var favorite: Bool
}
