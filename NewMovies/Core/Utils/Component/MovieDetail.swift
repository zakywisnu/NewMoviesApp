//
//  MovieDetail.swift
//  NewMovies
//
//  Created by Ahmad Zaky on 05/03/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetail: View {
    
    var movie: MovieModel
    var namespace: Namespace.ID
    
    var body: some View {
        VStack {
            ScrollView {
                ZStack {
                    WebImage(url: URL(string: MovieConstant.imageURL + movie.backdropPath))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    WebImage(url: URL(string: MovieConstant.imageURL + movie.posterPath))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(22)
                        .frame(width: 200, height: 200)
                        .offset(y: 100)
                        .matchedGeometryEffect(id: movie.id, in: namespace)
                }
                .padding(.bottom, 100)
                
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
//                            if movie.favorite {
//                                Image(systemName: "heart.fill")
//                                    .font(.system(size: 28))
//                                    .foregroundColor(.red)
//                            } else {
//                                Image(systemName: "heart")
//                                    .font(.system(size: 28))
//                            }
//                            
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
                
            }
        }
        .matchedGeometryEffect(id: "container\(movie.id)", in: namespace)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct MovieDetail_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        MovieDetail(
            movie: MovieModel(
                id: 0,
                title: "Wonder Woman 1984",
                posterPath: "/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg",
                voteAverage: 8.0,
                backdropPath:"/srYya1ZlI97Au4jUYAktDe3avyA.jpg",
                overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s and finds a formidable foe by the name of the Cheetah.",
                releaseDate: "2020-12-16",
                favorite: false), namespace: namespace
        )
    }
}
