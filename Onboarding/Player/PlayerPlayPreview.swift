//
//  PlayerPlayPreview.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 13.09.2021.
//

import SwiftUI
import AVFoundation

struct PlayerPlayPreview: View {
    
    @Binding var isPlaing: Bool
    @State private var animationAmount: CGFloat = 1.0
    
    private let animation = Animation.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.2)
    let player: AVPlayer
    
    var body: some View {
        ZStack {

            Image("videoPrevImg")
                .resizable()
                .frame(width: 335, height: 335)
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .scaleEffect(animationAmount)
                .shadow(color: !isPlaing ? .clear : .black.opacity(0.8), radius: 8, x: 5.0, y: 5.0)
                .animation(animation, value: animationAmount)
            
            
            Image(systemName: !isPlaing ? "play.circle.fill" : "pause.circle.fill")
                .resizable()
                .foregroundColor(.white)
                .background(Color("playButtonColor")).clipShape(Circle())
                .frame(width: 64, height: 64)
                .onTapGesture {
                    isPlaing.toggle()
                    if isPlaing {
                        player.play()
                        animationAmount = 1.1
                    } else {
                        player.pause()
                        animationAmount = 1
                    }
                }
            
        }.onChange(of: isPlaing ) { value in
            DispatchQueue.main.async {
                !value ? (animationAmount = 1.0) : (animationAmount = 1.1)
            }
        }
    }
}

struct PlayerPlayPreview_Previews: PreviewProvider {
    static var previews: some View {
        PlayerPlayPreview(isPlaing: .constant(true), player: AVPlayer())
    }
}
