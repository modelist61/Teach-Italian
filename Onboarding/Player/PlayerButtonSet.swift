//
//  PlayerButtonSet.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 15.09.2021.
//

import SwiftUI
import AVFoundation

struct PlayerButtonSet: View {
    
//    let destination: Content
    let changeButton: Bool
    let player: AVPlayer
    @GestureState var longPress = false
    @State private var timer: Timer?
    @State private var isLongPressing = false
    @Binding var isPlaing: Bool
    
    var body: some View {
        HStack(spacing: 36) {
            HStack(spacing: 40) {
                Button(action: {
                    if isLongPressing {
                        isLongPressing.toggle()
                        timer?.invalidate()
                    } else {
                        seek(set: .Backward, seconds: 30)
                    }
                },
                label: {
                    Image(systemName: "backward.fill")
                        .makeResizable(height: 18)
                        .foregroundColor(changeButton ? .white : .red)
                })
                .simultaneousGesture(LongPressGesture(minimumDuration: 0.2).onEnded { _ in
                    isLongPressing = true
                    timer = Timer.scheduledTimer(withTimeInterval: 0.1,
                                                 repeats: true,
                                                 block: { _ in
                                                    seek(set: .Backward, seconds: 5)
                                                 })
                })
                
                if changeButton {
                    Image(systemName: !isPlaing ?
                            "play.fill" :
                            "pause.fill")
                        .makeResizable(width: 35, height: 35)
                        .onTapGesture {
                            isPlaing.toggle()
                            isPlaing ? player.play() : player.pause()
                        }
                } else {
                    Image(systemName: !isPlaing ?
                            "play.circle.fill" :
                            "pause.circle.fill")
                        .makeResizable(width: 36, height: 36)
                        .foregroundColor(!changeButton && isPlaing ? .white : .red)
                        .onTapGesture {
                            isPlaing.toggle()
                            isPlaing ? player.play() : player.pause()
                        }
                }
                
                Button(action: {
                    if isLongPressing {
                        isLongPressing.toggle()
                        timer?.invalidate()
                    } else {
                        seek(set: .Forward, seconds: 30)
                    }
                },
                label: {
                    Image(systemName: "forward.fill")
                        .makeResizable(height: 18)
                        .foregroundColor(changeButton ? .white : .red)
                })
                .simultaneousGesture(LongPressGesture(minimumDuration: 0.2).onEnded { _ in
                    print("long press")
                    isLongPressing = true
                    timer = Timer.scheduledTimer(withTimeInterval: 0.1,
                                                 repeats: true,
                                                 block: { _ in
                                                    seek(set: .Forward, seconds: 5)
                                                 })
                })
            }
            .foregroundColor(.white)
            
            //SHOW SHEET VIEW
//            .onTapGesture {
//                showingSheet.toggle()
//            }
            
        }
    }
    enum seekEnum {
        case Forward
        case Backward
    }
    private func seek(set: seekEnum, seconds: Double) {
        switch set {
        case .Backward:
            player.seek(to: CMTime(seconds: player.currentTime().seconds - seconds,
                                   preferredTimescale: 600))
        case .Forward:
            player.seek(to: CMTime(seconds: player.currentTime().seconds + seconds,
                                   preferredTimescale: 600))
        }
    }
}

struct PlayerButtonSet_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("onboardingBackgroundColor").ignoresSafeArea()
            PlayerButtonSet(changeButton: false, player: AVPlayer(), isPlaing: .constant(true))
        }
    }
}
