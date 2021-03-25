//
//  MovieList.swift
//  NewMovies
//
//  Created by Ahmad Zaky on 01/02/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieList: View {
    
    var movie: MovieModel
    
    var body: some View {
        ZStack {
            WebImage(url: URL(string: MovieConstant.imageURL + movie.posterPath))
                .resizable()
                .indicator(.activity)
                .cornerRadius(20)
                .frame(width: 165, height: 250)
            VStack {
                Spacer()
                
                HStack {
                    VStack(alignment:.leading) {
                        Text(movie.title)
                            .font(.caption)
                            .fontWeight(.bold)
                            .frame(width: 100, height: 40,alignment: .leading)
                            .padding(.leading,8)
                            .foregroundColor(Color.black.opacity(0.9))
                        
                        Text(movie.releaseDate)
                            .font(.caption2)
                            .frame(height: 20)
                            .padding(.leading,10)
                            .padding(.bottom, 5)
                            .foregroundColor(Color.black.opacity(0.9))
                    }
                    Spacer()
                    RingView(width: 33, height: 33, percent: CGFloat(movie.voteAverage), show: true)
                        .offset(x: -5)
                        .animation(Animation.easeInOut)
                    
                }
                .frame(height: 60)
                .background(Color.white.opacity(0.5))
                
            }
        }
        .frame(width:165, height: 250)
        .cornerRadius(10)
    }
}

struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        MovieList(
            movie: MovieModel(
                id: 0,
                title: "Wonder Woman 1984",
                posterPath: "/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg",
                voteAverage: 8.0,
                backdropPath: "https://image.tmdb.org/t/p/w500/srYya1ZlI97Au4jUYAktDe3avyA.jpg",
                overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s and finds a formidable foe by the name of the Cheetah.",
                releaseDate: "2020-12-16",
                favorite: false)
        )
    }
}

