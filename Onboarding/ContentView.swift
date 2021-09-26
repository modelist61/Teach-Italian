//
//  ContentView.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 27.08.2021.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @StateObject private var progress = CurrentProgress(lessons: lessons)
    @AppStorage("showRating") var showRating = true
    @AppStorage("OnboardBeenViewed") var hasOnBoarded = true
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let center = UNUserNotificationCenter.current()
    let lunchTimer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    @State private var showLunch = true

        
    var body: some View {
        ZStack {
            if hasOnBoarded {
                OnBoardView(isPresening: $hasOnBoarded)
                    .transition(.identity)
            } else if showRating && !hasOnBoarded {
                RaitingView(dismiss: $showRating)
                    .transition(.scale)
            } else if showLunch {
                LunchScreen()
            } else {
                HomeView()
            }
        }
        .onReceive(lunchTimer) { _ in
            showLunch = false
            lunchTimer.upstream.connect().cancel()
        }
        .onReceive(timer) { _ in
            center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            }
            timer.upstream.connect().cancel()
        }
        
    }
//    func playerItem(index: Int) -> AVPlayerItem? {
//        guard let url = URL(string: progress.lessonList[index].url) else { return nil }
//        return AVPlayerItem(url: url)
//    }
    
//    func updateSaving() -> [Double] {
//        udCheckIsNil(udKey: "progress", defaultVal: makeDefaultProgress())
//    }
    
//    private func makeDefaultProgress() -> [Double] {
//        var seconds: [Double] = []
//        for _ in 0...lessons.count {
//            seconds.append(0.0)
//        }
//        return seconds
//    }
    
//    private func udCheckIsNil(udKey: String, defaultVal: [Double]) -> [Double] {
//        let defaults = UserDefaults.standard
//        if(defaults.array(forKey: udKey) != nil) {
//            return defaults.array(forKey: udKey) as! [Double]
//        } else {
//            return defaultVal
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


