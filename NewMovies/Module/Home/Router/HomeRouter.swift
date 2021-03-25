//
//  HomeRouter.swift
//  NewMovies
//
//  Created by Ahmad Zaky on 14/02/21.
//

import Foundation
import SwiftUI

class HomeRouter {
    func makeDetailView(for movies: MovieModel) -> some View {
        let detailUseCase = Injection.init().provideDetail(by: movies.id)
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        return DetailView(presenter: presenter)
    }
}
