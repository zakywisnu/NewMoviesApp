//
//  FavoriteRouter.swift
//  NewMovies
//
//  Created by Ahmad Zaky on 15/02/21.
//

import Foundation
import SwiftUI

class FavoriteRouter {
    func makeDetailView(for movie: MovieModel) -> some View {
        let detailUseCase = Injection.init().provideDetail(by: movie.id)
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        return DetailView(presenter: presenter)
    }
}
