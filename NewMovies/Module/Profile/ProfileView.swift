//
//  ProfileView.swift
//  NewMovies
//
//  Created by Ahmad Zaky on 15/02/21.
//

import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Ahmad Zaky Wisnumurti")
                .font(.system(size: 16, weight: .bold, design: .default))
            Text("Android & iOS Developer")
                .font(.system(size: 14, weight: .light, design: .default))
            
            MenuRow(title: "zakywisnu", icon: "github")
            MenuRow(title: "Ahmad Zaky Wisnumurti", icon: "linkedin")
        }
        .frame(width: screen.width - 64, height: 300)
        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))]), startPoint: .top, endPoint: .bottom))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
        .padding(.horizontal, 30)
        .overlay(
            Image("foto_zaky")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .offset(y:-150)
        )
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

struct MenuRow: View {
    var title: String
    var icon: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(icon)
                .resizable()
                .font(.system(size: 20, weight: .light))
                .imageScale(.large)
                .frame(width: 32, height: 32)
                .foregroundColor(Color(#colorLiteral(red: 0.662745098, green: 0.7333333333, blue: 0.831372549, alpha: 1)))
            
            
            Text(title)
                .font(.system(size: 16, weight: .bold, design: .default))
                .frame(width: 120, alignment: .leading)
        }
    }
}
