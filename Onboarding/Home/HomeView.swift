//
//  HomeView.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 02.09.2021.
//

import SwiftUI
import AVFoundation

struct HomeView: View {
    
    //    let player = AVPlayer()
    @ObservedObject var progress: CurrentProgress
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color("onboardingBackgroundColor").ignoresSafeArea()
                ScrollView {
                    ForEach(lessons.indices, id: \.self) { index in
                        NavigationLink(destination: PlayerView(index: index, player: progress.player, progress: progress)) {
                            LessonPreview(index: index, progress: progress)
                        }
                    }
                }
                BottomLinerGradient()
            }.navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    CustomToolBar()
                }
                
            }
        }.accentColor( .white)
        .onAppear(perform: {
            print("update duration \(progress.allLessonsDuration)")
        })
        
        
        
    }
    
    private var profileButton: some View {
        Button(action: { }) {
            Image(systemName: "person.crop.circle")
        }
    }
    
    func playerItem(index: Int) -> AVPlayerItem? {
//        let currentTime = progress.currentProgressSeconds[index]
        guard let url = URL(string: progress.lessonList[index].url) else { return nil }
//        currentUrl = url
        return AVPlayerItem(url: url)
//        self.player.replaceCurrentItem(with: playerItem)
//        player.seek(to: CMTime(seconds: currentTime, preferredTimescale: 600))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(progress: CurrentProgress(lessons: lessons))
    }
}


struct BottomLinerGradient: View {
    var body: some View {
        VStack {
            EmptyView()
            Spacer()
            LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.4)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all, edges: .bottom)
                .frame(height: 100)
        }
    }
}



