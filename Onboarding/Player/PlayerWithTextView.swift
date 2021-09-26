//
//  PlayerWithTextView.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 13.09.2021.
//

import SwiftUI
import AVFoundation

struct PlayerWithTextView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let index: Int
    let currentUrl: URL
    let player: AVPlayer//
//    let player = AVPlayer()

//    @ObservedObject var progress: CurrentProgress
    @EnvironmentObject var progress: CurrentProgress
    @State private var isPlaing = false
    @Binding var currentSeconds: Double
    
    private let animation = Animation
        .easeInOut(duration: 0.0)
        .repeatForever(autoreverses: false)
    @State var animate = false
    
    var body: some View {
//        let player = progress.player
        
        ZStack {
            Color("onboardingBackgroundColor").ignoresSafeArea()
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(.white.opacity(0.2))
                    Text("""
                        Ascolta questa conversazione.
                        S - Mi scusi, signorina. Capisci il russo?
                        M - No, signore. Non capisco il russo.

                        S - Capisco un po' lo spagnolo.
                        M - Sei russo?
                        S - Sì, signorina.

                        In pochi minuti non solo capirai il significato di questa conversazione, ma sarai in grado di parteciparvi tu stesso.
                        Immagina un russo che è venuto negli Stati Uniti. Vuole parlare con la donna americana accanto a lui.
                        """)
                        .lineSpacing(8)
                        .font(Font(UIFont(name: "SFUIDisplay-Regular", size: 20)!))
                        .foregroundColor(.white)
                        .padding()
                    
                }.frame(width: 347, height: 616)
                
                AudioPlayerControlsView(player: player,
                                        timeObserver: PlayerTimeObserver(player: player),
                                        durationObserver: PlayerDurationObserver(player: player),
                                        itemObserver: PlayerItemObserver(player: player),
                                        durationPreLoad: progress.allLessonsDuration[index],
                                        currentTimeFromUD: currentSeconds)
                    .animation(animation, value: animate)
                
                HStack {
                    PlayerButtonSet(changeButton: false,
                                    player: player,
                                    isPlaing: $isPlaing)
                        .padding(.vertical, 30)
                }
            }
            PlayerBottomGradient()
            
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            CustomChildToolBar(text: "Lezione \(index + 1)")
        }
        .onReceive(player.currentItem.publisher) { player2 in
            currentSeconds = player2.currentTime().seconds
        }
        .onDisappear {
            onDisappear()
        }.onAppear {
            onAppear()
            
        }
    }
    
    private func onDisappear() {
        print("ONDISAPPEAR PlayerTextView")
        player.pause()
    }
    
    private func onAppear() {
        print("ONAPPEAR PlayerTextView")
        player.pause()
        DispatchQueue.main.async {
            animate = true
            let playerItem = AVPlayerItem(url: currentUrl)
            player.replaceCurrentItem(with: playerItem)
            player.seek(to: CMTime(seconds: currentSeconds, preferredTimescale: 600))
        }
    }

}

struct PlayerWithTextView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerWithTextView(index: 0, currentUrl: URL(string: "https://englishforlesson.space//Italian/level1/1.mp3")!, player: AVPlayer(), currentSeconds: .constant(200))
    }
}
