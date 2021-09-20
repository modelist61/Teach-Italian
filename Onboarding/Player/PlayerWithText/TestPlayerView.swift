//
//  PlayerView.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 06.09.2021.
//

import SwiftUI
import AVFoundation

struct TestPlayerView: View {
    
    let index: Int
    let player: AVPlayer//
//    var currentItem:
    
    @ObservedObject var progress: CurrentProgress
    @State private var isPlaing = false
    @State private var currentSeconds = 0.0
    @State private var animationAmount: CGFloat = 1 //ANIMATION
    @State private var showingSheet = false //SHEET
    
//    @State private var currentItem = AVPlayerItem.self
    
    
    
    
    var body: some View {
        ZStack {
            Color("onboardingBackgroundColor").ignoresSafeArea()
            VStack {
                
                PlayerPlayPreview(isPlaing: $isPlaing, animationAmount: $animationAmount, player: player)
                
                VStack(spacing: 10) {
                    Text("Lezione 0\(lessons[index].lesson)")
                        .font(Font(UIFont(name: "SFUIDisplay-Medium", size: 24)!))
                    Text("Livello \(lessons[index].level)")
                        .font(Font(UIFont(name: "SFUIDisplay-Regular", size: 18)!))
                    
                    AudioPlayerControlsView(player: player,
                                            timeObserver: PlayerTimeObserver(player: player),
                                            durationObserver: PlayerDurationObserver(player: player),
                                            itemObserver: PlayerItemObserver(player: player))
                }.foregroundColor(.white)
                .padding(.vertical, 25)
                
                
                HStack(spacing: 36) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 7)
                            .frame(width: 33, height: 33)
                            .foregroundColor(.white)
                        Image(systemName: "list.bullet")
                            .foregroundColor(Color("playButtonColor"))
                    }.opacity(0.0)
                    
                    HStack(spacing: 40) {
                        Image(systemName: "backward.fill")
                            .makeResizable(height: 18)
                            .onTapGesture {
                                seek(set: .Backward)
                            }
                        
                        Image(systemName: !isPlaing ? "play.fill" : "pause.fill")
                            .makeResizable(width: 35, height: 35)
                            .onTapGesture {
                                isPlaing.toggle()
                                isPlaing ? player.play() : player.pause()
                                
                                if isPlaing {
                                    animationAmount = 1.1
                                } else {
                                    animationAmount = 1
                                }
                            }
                        Image(systemName: "forward.fill")
                            .makeResizable(height: 18)
                            .onTapGesture {
                                seek(set: .Forward)
                            }
                    }
                    .foregroundColor(.white)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 7)
                            .frame(width: 33, height: 33)
                            .foregroundColor(.white)
                        Image(systemName: "list.bullet")
                            .foregroundColor(Color("playButtonColor"))
                    }
                    //SHOW SHEET VIEW
                    .onTapGesture {
                        showingSheet.toggle()
                    }
                    
                }.padding(.vertical, 30)
                
                
            }
//            PlayerBottomGradient()
        }.sheet(isPresented: $showingSheet) {
            SheetView()
        }
        .onChange(of: player.currentTime().isValid) { _ in
            currentSeconds = player.currentTime().seconds
        }
        .onDisappear {
            onDisappear()
        }
        .onAppear {
            onAppear()
        }
    }
    
    enum seekEnum {
        case Forward
        case Backward
    }
    private func seek(set: seekEnum) {
        switch set {
        case .Backward:
            player.seek(to: CMTime(seconds: player.currentTime().seconds - 30, preferredTimescale: 600))
        case .Forward:
            player.seek(to: CMTime(seconds: player.currentTime().seconds + 30, preferredTimescale: 600))
        }
        
    }
    
    private func onDisappear() {
        print("* DISMISS test VIEW")
//        let progInSec = currentSeconds
        progress.currentProgressSeconds[index] = currentSeconds
        progress.refreshProgress(index: index)
        progress.writeSavingToUD()
        player.pause()
        self.player.replaceCurrentItem(with: nil)
    }
    
    private func onAppear() {
        print("* ONAPEPEAR test VIEW")
        let currentTime = progress.currentProgressSeconds[index]
        guard let url = URL(string: lessons[index].url) else { return }
        let playerItem = AVPlayerItem(url: url)
        self.player.replaceCurrentItem(with: playerItem)
        player.seek(to: CMTime(seconds: currentTime, preferredTimescale: 600))
    }
}

struct TestPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(index: 0, player: AVPlayer(), progress: CurrentProgress(secondsArray: Array(repeating: 0, count: lessons.count), percentArray: Array(repeating: 0, count: lessons.count)), currentSeconds: .constant(100))
    }
}

//extension Image {
//    func makeResizable(width: CGFloat? = nil,
//                       height: CGFloat) -> some View {
//        self
//            .resizable()
//            .aspectRatio(contentMode: .fit)
//            .frame(width: width, height: height)
//    }
//}

//struct PlayerBottomButton: View {
//
//    let text: String
//    let icon: String
//
//    var body: some View {
//        ZStack {
//            RoundedRectangle(cornerRadius: 15)
//                .frame(height: 40)
//            Text(text)
//                .font(Font(UIFont(name: "SFUIDisplay-Medium", size: 18)!))
//                .foregroundColor(.white)
//
//            Image(icon)
//                .resizable()
//                .frame(width: 24, height: 24)
//                .padding(.leading, 170)
//        }.frame(width: 345)
//        .foregroundColor(.white.opacity(0.2))
//
//    }
//}

//struct PlayerBottomGradient: View {
//    var body: some View {
//        VStack {
//            EmptyView()
//            Spacer()
//            LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.4)]), startPoint: .top, endPoint: .bottom)
//                .ignoresSafeArea(.all, edges: .bottom)
//                .frame(height: 10)
//        }
//    }
//}


