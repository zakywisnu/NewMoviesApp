//
//  MovieRow.swift
//  NewMovies
//
//  Created by Ahmad Zaky on 05/03/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieRow: View {
    
    var movie: MovieModel
    
    var body: some View {
        VStack {
            WebImage(url: URL(string: MovieConstant.imageURL + movie.posterPath))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        }
        .padding(.all)
        .shadow(color: Color.black.opacity(0.4), radius: 10, x: 0, y: 10)
    }
}

struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
        MovieRow(
            movie: MovieModel(
                id: 0,
                title: "Wonder Woman 1984",
                posterPath: "/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg",
                voteAverage: 8.0,
                backdropPath: "https://image.tmdb.org/t/p/w500/srYya1ZlI97Au4jUYAktDe3avyA.jpg",
                overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s and finds a formidable foe by the name of the Cheetah.",
                releaseDate: "2020-12-16",
                favorite: false))
    }
}
