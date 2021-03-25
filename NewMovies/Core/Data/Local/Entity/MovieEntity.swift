//
//  MovieEntity.swift
//  NewMovies
//
//  Created by Ahmad Zaky on 01/02/21.
//

import Foundation
import RealmSwift

class MovieEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var posterPath: String = ""
    @objc dynamic var backdropPath: String = ""
    @objc dynamic var voteAverage: Double = 0
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var favorite: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
