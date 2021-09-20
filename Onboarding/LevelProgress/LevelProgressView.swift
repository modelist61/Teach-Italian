//
//  LevelProgressView.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 17.09.2021.
//

import SwiftUI

struct LevelProgressView: View {
    
    @ObservedObject var progress: CurrentProgress
    
    var body: some View {
        ZStack(alignment: .top) {
            Color("onboardingBackgroundColor")
                .ignoresSafeArea()
            HStack {
                VStack(alignment: .leading) {
                    Text("Level 1")
                        .font(Font(UIFont(name: "SFUIDisplay-Medium", size: 18)!))
                    Text("Lessons 1-30")
                        .font(Font(UIFont(name: "SFUIDisplay-Medium", size: 14)!))
                        .opacity(0.8)
                    Rectangle()
                        
                        .frame(height: 1)
                }.foregroundColor(.white)
                CircleProgress(progress: progress.calcAverageLevelPercent())
            }.frame(width: UIScreen.main.bounds.width - 32)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            CustomChildToolBar(text: "difficulty level")
//                .offset(x: 3, y: 0)
        })
        .onAppear {
            print("ONAPPEAR LevelsProgress")
        }
        .onDisappear {
            print("ONDISAPPEAR LevelsProgress")
        }
}
}

struct LevelProgressView_Previews: PreviewProvider {
    static var previews: some View {
        LevelProgressView(progress: CurrentProgress(lessons: lessons))
    }
}

struct CircleProgress: View {
    
    let progress: Int
    
    private let animation = Animation.easeInOut(duration: 0.1).repeatForever(autoreverses: false)
        @State var animate = false
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.white.opacity(0.3), style: StrokeStyle(lineWidth: 3, lineCap: .round))
                Circle()
                    .trim(from: 0.0, to: CGFloat(progress) / 100)
                    .stroke(Color.red, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(animation, value: animate)
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text("\(progress)")
                        .font(Font(UIFont(name: "SFUIDisplay-Medium", size: 18)!))
                    Text("%")
                        .font(Font(UIFont(name: "SFUIDisplay-Medium", size: 12)!))
                }.foregroundColor(.white)
            }.frame(width: 54, height: 54)
        }.onAppear {
            DispatchQueue.main.async {
                animate = true
            }
        }
    }
}
