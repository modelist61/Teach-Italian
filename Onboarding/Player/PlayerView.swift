//
//  PlayerView.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 06.09.2021.
//

import SwiftUI
import AVFoundation

struct PlayerView: View {
        
//    let player2: AudioPlayer
    let index: Int
    let player: AVPlayer//
    @ObservedObject var progress: CurrentProgress
    @State private var isPlaing = false
    @State private var showingSheet = false //SHEET
    @State private var currentSeconds = 0.0
    @State private var currentUrl: URL? = URL(string: "http://")
    @State var isLongPressing = false
    @State var dismiss = false
    
    private let animation = Animation.easeInOut(duration: 0.0)
    @State var animate = false
    
    
    var body: some View {
        
        ZStack {
            Color("onboardingBackgroundColor")
                .ignoresSafeArea()
            VStack {
                
                PlayerPlayPreview(isPlaing: $isPlaing, player: player)
                
                VStack(spacing: 10) {
                    Text("Lezione 0\(lessons[index].lesson)")
                        .font(Font(UIFont(name: "SFUIDisplay-Medium", size: 24)!))
                    Text("Livello \(lessons[index].level)")
                        .font(Font(UIFont(name: "SFUIDisplay-Regular", size: 18)!))
                    
                    AudioPlayerControlsView(player: player,
                                            timeObserver: PlayerTimeObserver(player: player),
                                            durationObserver: PlayerDurationObserver(player: player),
                                            itemObserver: PlayerItemObserver(player: player), durationPreLoad: progress.allLessonsDuration[index])
                        .animation(animation, value: animate)
                }.foregroundColor(.white)
                .padding(.vertical, 25)
                
                HStack {
//                    PlayerButtonSet(changeButton: true,
//                                    player: player,
//                                    progress: progress,
//                                    isPlaing: $isPlaing)
//                        .padding(.vertical, 30)
                    
                    PlayerButtonSet(changeButton: true,
                                    player: player,
                                    progress: progress,
                                    isPlaing: $isPlaing)
                        .padding(.vertical, 30)
                }
                
                VStack {
                    NavigationLink(
                        destination: PlayerWithTextView(index: index, currentUrl: currentUrl!, player: player, progress: progress, currentSeconds: $currentSeconds),
                        isActive: $dismiss,
                        label: {
                            PlayerBottomButton(text: "Materiale di testo",
                                               icon: "noteImg")
                                .onTapGesture {
                                    dismiss.toggle()
                                }
                        })
                    PlayerBottomButton(text: "Scarica l'audio",
                                       icon: "downloadSimpleImg")
                        .onTapGesture {
                            showingSheet.toggle()
                        }
                }
            }
            PlayerBottomGradient()
        }.navigationBarBackButtonHidden(true)
        .toolbar(content: {
            CustomChildToolBar(text: "")
                .offset(x: 3, y: 0)
        })
        
        .sheet(isPresented: $showingSheet) {
            SheetView()
        }
        .onReceive(player.currentItem.publisher) { player2 in
            currentSeconds = player2.currentTime().seconds
            print("PLAYER 1 \(player2.currentTime().seconds)")
        }
        .onDisappear {
            !dismiss ? onDisappear() : player.pause()
        }
        .onAppear {
            onAppear()
        }
    }
    
    private func onDisappear() {
        print("ONDISAPPEAR PlayerView")
        player.pause()
        //        DispatchQueue.main.async {
        
        progress.currentProgressSeconds[index] = currentSeconds
        progress.refreshProgress(index: index)
        progress.writeSavingToUD()
        self.player.replaceCurrentItem(with: nil)
        //        }
    }
    
    private func onAppear() {
        print("ONAPPEAR PlayerView")
        player.pause()
        if !dismiss {
            currentSeconds = progress.currentProgressSeconds[index]
        }
        DispatchQueue.main.async {
            animate = true
            let currentTime = currentSeconds
            guard let url = URL(string: lessons[index].url) else { return }
            currentUrl = url
            let playerItem = AVPlayerItem(url: url)
            self.player.replaceCurrentItem(with: playerItem)
            player.seek(to: CMTime(seconds: currentTime, preferredTimescale: 600))
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(index: 0, player: AVPlayer(), progress: CurrentProgress(lessons: lessons))
    }
}

extension Image {
    func makeResizable(width: CGFloat? = nil,
                       height: CGFloat) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width, height: height)
    }
}

struct PlayerBottomButton: View {
    
    let text: String
    let icon: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(height: 40)
            Text(text)
                .font(Font(UIFont(name: "SFUIDisplay-Medium", size: 18)!))
                .foregroundColor(.white)
            
            Image(icon)
                .resizable()
                .frame(width: 24, height: 24)
                .padding(.leading, 170)
        }.frame(width: 345)
        .foregroundColor(.white.opacity(0.2))
        
    }
}

struct PlayerBottomGradient: View {
    var body: some View {
        VStack {
            EmptyView()
            Spacer()
            LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.4)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all, edges: .bottom)
                .frame(height: 10)
        }
    }
}


