//
//  RingView.swift
//  NewMovies
//
//  Created by Ahmad Zaky on 11/02/21.
//

import SwiftUI

struct RingView: View {
    
    var width: CGFloat = 88
    var height: CGFloat = 88
    var percent: CGFloat = 7.0
    @State var show: Bool
    var body: some View {
        let multiplier = width / 44
        let vote = percent * 10
        let progress = 1 - (percent/10)
        
        return ZStack {
            Circle()
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 5 * multiplier))
                .frame(width: width, height: height)
            Circle()
                .trim(from: show ? progress : 1, to: 1)
                .stroke(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)), Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))]), startPoint: .topTrailing, endPoint: .bottomLeading),
                        style: StrokeStyle(lineWidth: 5*multiplier, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20,0], dashPhase: 0)
                )
                .rotationEffect(Angle(degrees: 90))
                .rotation3DEffect(
                    Angle(degrees: 180),
                    axis: (x: 1.0, y: 0.0, z: 0.0))
                .frame(width: width, height: height)
                .onAppear{
                    self.show = true
                }
                .onDisappear {
                    self.show = false
                }
            
            
            Text("\(Int(vote))%")
                .font(.system(size: 14 * multiplier))
                .fontWeight(.bold)
        }
    }
}


struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView( show: false)
    }
}
