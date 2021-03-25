//
//  MovieMapper.swift
//  NewMovies
//
//  Created by Ahmad Zaky on 01/02/21.
//

import Foundation

final class MovieMapper {
    static func mapMovieResponsesToEntities(
        input movieResponse: [MovieResponse]
    ) -> [MovieEntity] {
        return movieResponse.map{ result in
            let movieEntity = MovieEntity()
//            movieEntity.id = result.id ?? ""
            movieEntity.id = result.id ?? 0
            movieEntity.title = result.title ?? ""
            movieEntity.voteAverage = result.voteAverage ?? 0
            movieEntity.releaseDate = result.releaseDate ?? ""
            movieEntity.posterPath = result.posterPath ?? ""
            movieEntity.overview = result.overview ?? ""
            movieEntity.backdropPath = result.backdropPath ?? ""
            
            return movieEntity
        }
    }
    
    static func mapMovieResponseToEntity(
        input movieResponse: MovieResponse
    ) -> MovieEntity {
        let movieEntity = MovieEntity()
//        movieEntity.id = movieResponse.id ?? ""
        movieEntity.id = movieResponse.id ?? 0
        movieEntity.title = movieResponse.title ?? ""
        movieEntity.voteAverage = movieResponse.voteAverage ?? 0
        movieEntity.releaseDate = movieResponse.releaseDate ?? ""
        movieEntity.posterPath = movieResponse.posterPath ?? ""
        movieEntity.overview = movieResponse.overview ?? ""
        movieEntity.backdropPath = movieResponse.backdropPath ?? ""
        return movieEntity
    }
    
    static func mapMovieEntitiesToDomains(
        input movieEntity: [MovieEntity]
    ) -> [MovieModel] {
        return movieEntity.map{ result in
            return MovieModel(
                id: result.id,
                title: result.title,
                posterPath: result.posterPath,
                voteAverage: result.voteAverage,
                backdropPath: result.backdropPath,
                overview: result.overview,
                releaseDate: result.releaseDate,
                favorite: result.favorite
            )
        }
    }
    
    static func mapMovieEntityToDomain(
        input movieEntity: MovieEntity
    ) -> MovieModel {
        return MovieModel(
            id: movieEntity.id,
            title: movieEntity.title,
            posterPath: movieEntity.posterPath,
            voteAverage: movieEntity.voteAverage,
            backdropPath: movieEntity.backdropPath,
            overview: movieEntity.overview,
            releaseDate: movieEntity.releaseDate,
            favorite: movieEntity.favorite)
    }
    
    static func mapMovieResponsesToDomains(
        input movieResponse: [MovieResponse]
    ) -> [MovieModel] {
        return movieResponse.map{ result in
            return MovieModel(
                id: result.id ?? 0,
                title: result.title ?? "",
                posterPath: result.posterPath ?? "",
                voteAverage: result.voteAverage ?? 0,
                backdropPath: result.backdropPath ?? "",
                overview: result.overview ?? "",
                releaseDate: result.releaseDate ?? "",
                favorite: false)
        }
    }
    
    
}
