//
//  MovieDetailTopBar.swift
//  NewMovies
//
//  Created by Ahmad Zaky on 14/02/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailTopBar: View {
    var movie: MovieModel
    var body: some View {
        VStack {
            //            ZStack() {
            //                WebImage(url: URL(string: MovieConstant.imageURL + movie.backdropPath))
            //                    .resizable()
            //                    .indicator(.activity)
            //                WebImage(url: URL(string: MovieConstant.imageURL + movie.posterPath))
            //                    .resizable()
            //                    .indicator(.activity)
            //                    .cornerRadius(20)
            //                    .frame(width: 135, height: 200)
            //                    .offset(y: 100)
            //            }
            
            WebImage(url: URL(string: MovieConstant.imageURL + movie.backdropPath))
                .resizable()
                .indicator(.activity)
                .frame(maxWidth:.infinity)
                .frame(height: 250)
                .overlay(
                    WebImage(
                        url: URL(string: MovieConstant.imageURL + movie.posterPath))
                            .resizable()
                            .indicator(.activity)
                            .cornerRadius(20)
                            .frame(width: 135, height: 200)
                            .offset(y: 100)
                )
            
            Spacer()
            
            VStack(alignment: .leading){
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 40) {
                        Text(movie.title)
                            .font(.system(size: 20, weight: .bold, design: .default))
                        Text(movie.releaseDate)
                            .font(.system(size: 16, weight: .light, design: .default))
                    }
                    Spacer()
                    VStack {
                        if movie.favorite {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 28))
                                .foregroundColor(.red)
                        } else {
                            Image(systemName: "heart")
                                .font(.system(size: 28))
                        }
                        
                        RingView(width: 44, height: 44, percent: CGFloat(movie.voteAverage), show: true)
                            .padding()
                            .animation(Animation.easeInOut.delay(0.3))
                    }
                    
                }
                
                Text(movie.overview)
                
                Spacer()
                
                
            }
            .frame(width: screen.width - 64, height: 400)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), Color(#colorLiteral(red: 0.8705882353, green: 0.8941176471, blue: 0.9450980392, alpha: 1))]), startPoint: .top, endPoint: .bottom))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .padding(.horizontal, 30)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            
            
            
            Spacer()
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct MovieDetailTopBar_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailTopBar(
            movie: MovieModel(
                id: 0,
                title: "Wonder Woman 1984",
                posterPath: "/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg",
                voteAverage: 8.0,
                backdropPath:"/srYya1ZlI97Au4jUYAktDe3avyA.jpg",
                overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s and finds a formidable foe by the name of the Cheetah.",
                releaseDate: "2020-12-16",
                favorite: false)
        )
    }
}
