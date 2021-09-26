//
//  OnboardingApp.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 27.08.2021.
//

import SwiftUI
import AVFoundation

@main
struct OnboardingApp: App {
    @StateObject private var progress = CurrentProgress(lessons: lessons)
   
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(progress)
                .onAppear {
                        progress.checItemUrl()
                        progress.updateSaving(udKey: "progress")
                        progress.fetchDurations()
                    
                }
        }
    }
}
