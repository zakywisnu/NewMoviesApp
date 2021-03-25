//
//  DetailView.swift
//  NewMovies
//
//  Created by Ahmad Zaky on 14/02/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    @ObservedObject var presenter: DetailPresenter
    
    var body: some View {
        
        ZStack {
            if presenter.isLoading {
                detailLoadingIndicator
            } else if presenter.isError {
                detailErrorIndicator
            } else {
                detailContent
            }
        }.onAppear(perform: {
            self.presenter.getMovieDetail()
        })
        
    }
}
extension DetailView {
    
    var detailLoadingIndicator: some View {
        LoadingView()
    }
    var detailErrorIndicator: some View {
        CustomEmptyView(image: "movie_icon", title: presenter.errorMessage)
    }
    
    var detailContent: some View {
        VStack {
            
            WebImage(url: URL(string: MovieConstant.imageURL + presenter.movie.backdropPath))
                .resizable()
                .indicator(.activity)
                .frame(maxWidth:.infinity)
                .frame(height: 250)
                .overlay(
                    WebImage(
                        url: URL(string: MovieConstant.imageURL + presenter.movie.posterPath))
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
                        Text(presenter.movie.title)
                            .font(.system(size: 20, weight: .bold, design: .default))
                        Text(presenter.movie.releaseDate)
                            .font(.system(size: 16, weight: .light, design: .default))
                    }
                    Spacer()
                    VStack {
                        if presenter.movie.favorite {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 28))
                                .foregroundColor(.red)
                                .onTapGesture {
                                    self.presenter.updateFavoriteMovie()
                                }
                        } else {
                            Image(systemName: "heart")
                                .font(.system(size: 28))
                                .onTapGesture {
                                    self.presenter.updateFavoriteMovie()
                                }
                        }
                        
                        RingView(width: 44, height: 44, percent: CGFloat(presenter.movie.voteAverage), show: true)
                            .padding()
                            .animation(Animation.easeInOut.delay(0.7))
                    }
                    
                }
                
                Text(presenter.movie.overview)
                
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


let screen = UIScreen.main.bounds
