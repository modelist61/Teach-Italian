//
//  HomeView.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 02.09.2021.
//

import SwiftUI
import AVFoundation

struct HomeView: View {
    
    let player = AVPlayer()
//    @ObservedObject var progress: CurrentProgress
    @EnvironmentObject var progress: CurrentProgress
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color("onboardingBackgroundColor").ignoresSafeArea()
                ScrollView {
                    ForEach(lessons.indices, id: \.self) { index in
                        NavigationLink(
                            destination: PlayerView(index: index),
                            label: {
                                VStack {
                                    LessonPreview(index: index)
                                }
                            })
                    }
                }
                BottomLinerGradient()
            }.navigationBarTitleDisplayMode(.automatic)
                .toolbar {
                    CustomToolBar()
                }
        }
//        .navigationBarColor(UIColor.orange)

//        .accentColor( .white)
    }
    
    private var profileButton: some View {
        Button(action: { }) {
            Image(systemName: "person.crop.circle")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


struct BottomLinerGradient: View {
    var body: some View {
        VStack {
            EmptyView()
            Spacer()
            LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.4)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all, edges: .bottom)
                .frame(height: 80)
        }
    }
}



