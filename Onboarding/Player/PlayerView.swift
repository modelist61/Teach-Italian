//
//  PlayerView.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 06.09.2021.
//

import SwiftUI
import AVFoundation

struct PlayerView: View {
    
    let index: Int

    @EnvironmentObject var progress: CurrentProgress
    
    @State private var isPlaing = false
    @State private var showingSheet = false //SHEET
    @State private var currentSeconds = 0.0
    @State private var currentUrl: URL? = URL(string: "http://")
    @State private var isLongPressing = false
    @State private var dismiss = false
    
    private let animation = Animation.easeInOut(duration: 0.0)
    @State private var animate = false
    @State private var offSetForLevels: CGFloat = 600
    
    var body: some View {
        let offSetCenter = (UIScreen.main.bounds.height / 3) - 120
        let player = progress.player
        
        ZStack {
            Color("onboardingBackgroundColor")
                .ignoresSafeArea()
                .brightness(offSetForLevels == 600 ? 0 : -0.1)
            VStack {
                //bugFix for BlureBug on Device XSMAX
                Text("\(offSetForLevels)").foregroundColor(.clear)
                
                PlayerPlayPreview(isPlaing: $isPlaing, player: player)
                    .disabled(offSetForLevels == 600 ? false : true)
                
                VStack(spacing: 10) {
                    Text("Lezione \(index + 1)")
                        .font(Font(UIFont(name: "SFUIDisplay-Medium", size: 24)!))
                    Text("Livello \(lessons[index].level)")
                        .font(Font(UIFont(name: "SFUIDisplay-Regular", size: 18)!))
                    
                    AudioPlayerControlsView(player: player,
                                            timeObserver: PlayerTimeObserver(player: player),
                                            durationObserver: PlayerDurationObserver(player: player),
                                            itemObserver: PlayerItemObserver(player: player),
                                            durationPreLoad: progress.allLessonsDuration[index],
                                            currentTimeFromUD: currentSeconds)
                        .animation(animation, value: animate)
                }.foregroundColor(.white)
                .padding(.vertical, 25)
                
                HStack {
                    Rectangle().frame(width: 33, height: 33).opacity(0.0)
                    Spacer()
                    
                    PlayerButtonSet(changeButton: true,
                                    player: player,
                                    isPlaing: $isPlaing)
                        .padding(.vertical, 30)
                    
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 7)
                            .frame(width: 33, height: 33)
                            .foregroundColor(.white)
                        Image(systemName: "list.bullet")
                            .foregroundColor(Color("playButtonColor"))
                    }.onTapGesture {
//                        showingSheet.toggle()
                        withAnimation(Animation?.init(.easeInOut(duration: 0.8))) {
                            if offSetForLevels == offSetCenter {
                                offSetForLevels = 600
                            } else if offSetForLevels == 600 {
                                offSetForLevels = offSetCenter
                            }
                        }
                    }
                    
//                    NavigationLink(destination: LevelProgressView()) {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 7)
//                                .frame(width: 33, height: 33)
//                                .foregroundColor(.white)
//                            Image(systemName: "list.bullet")
//                                .foregroundColor(Color("playButtonColor"))
//                        }
//                    }
                }.frame(width: 335)
                
                VStack {
                    NavigationLink(
                        destination: PlayerWithTextView(index: index, currentUrl: currentUrl!, player: player, currentSeconds: $currentSeconds),
                        isActive: $dismiss,
                        label: {
                            PlayerBottomButton(text: "Materiale di testo",
                                               icon: "noteImg")
                        }).onTapGesture {
                            dismiss.toggle()
                        }
                    PlayerBottomButton(text: "Scarica l'audio",
                                       icon: "downloadSimpleImg")
                        .onTapGesture {
                            showingSheet.toggle()
                        }
                }
            }
            .blur(radius: offSetForLevels == 600 ? 0 : 3)
            .brightness(offSetForLevels == 600 ? 0 : -0.1)
                        
            //SHOW SHEET WITH LEVELS
            VStack(spacing: 40) {
                RoundedRectangle(cornerRadius: 100)
                    .frame(width: 100, height: 5, alignment: .center)
                    .foregroundColor(Color.white)
                
                LevelProgressView2()
                    
            }.offset(y: offSetForLevels)
            .gesture(DragGesture()
                        .onChanged { value in
                            withAnimation {
                                    offSetForLevels = value.location.y
                            }
                        }
                        .onEnded { value in
                            withAnimation {
                                offSetForLevels = 600
                            }
                        }
            )
            PlayerBottomGradient()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            CustomChildToolBar(text: "")
        }
        
        
        .sheet(isPresented: $showingSheet) {
                        SheetView()
//            LevelProgressView()
        }
//        .onReceive(player.currentItem.publisher) { player2 in
//            currentSeconds = player2.currentTime().seconds
//            print("PLAYER 1 \(player2.currentTime().seconds)")
//        }
        .onDisappear {
            !dismiss ? onDisappear() : player.pause()
        }
        .onAppear {
            onAppear()
        }
        
    }
    
    private func onDisappear() {
        print("ONDISAPPEAR PlayerView")
        isPlaing = false
//        if !((progress.player.currentItem?.currentTime().seconds.isNaN)!) {
            currentSeconds = progress.player.currentItem?.currentTime().seconds ?? 0.0
//        } else {
//            currentSeconds = 0.0
//        }
        progress.player.pause()
        DispatchQueue.main.async {
            progress.currentProgressSeconds[index] = currentSeconds
            progress.refreshProgress(index: index)
            progress.writeSavingToUD()
            progress.player.replaceCurrentItem(with: nil)
        }
    }
    
    private func onAppear() {
        print("ONAPPEAR PlayerView")
        isPlaing = false
        progress.player.pause()
        if !dismiss {
            currentSeconds = progress.currentProgressSeconds[index]
        }
        DispatchQueue.main.async {
            animate = true
            let currentTime = currentSeconds
            guard let url = URL(string: lessons[index].url) else { return }
            currentUrl = url
            progress.player.replaceCurrentItem(with: progress.allLessonsItem[index])
            progress.player.seek(to: CMTime(seconds: currentTime, preferredTimescale: 600))
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    @EnvironmentObject var progress: CurrentProgress

    static var previews: some View {
        PlayerView(index: 0).environmentObject(CurrentProgress(lessons: lessons))
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


