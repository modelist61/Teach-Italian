//
//  LevelProgressView2.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 21.09.2021.
//

import SwiftUI

struct LevelProgressView2: View {
    
    @EnvironmentObject var progress: CurrentProgress
    
    var body: some View {
        ZStack(alignment: .top) {
            Color("onboardingBackgroundColor")
                .ignoresSafeArea()
            VStack {
                
                Text("Difficulty level")
                    .font(Font(UIFont(name: "SFProRounded-Semibold", size: 24)!))
                    .foregroundColor(.white)
                
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
                    CircleProgress2(progress: progress.calcAverageLevelPercent())
                }.padding()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Level 2")
                            .font(Font(UIFont(name: "SFUIDisplay-Medium", size: 18)!))
                        Text("Lessons 31-60")
                            .font(Font(UIFont(name: "SFUIDisplay-Medium", size: 14)!))
                            .opacity(0.8)
                        Rectangle()
                            
                            .frame(height: 1)
                    }.foregroundColor(.white)
                    CircleProgress2(progress: 0)
                }.padding()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Level 3")
                            .font(Font(UIFont(name: "SFUIDisplay-Medium", size: 18)!))
                        Text("Lessons 61-90")
                            .font(Font(UIFont(name: "SFUIDisplay-Medium", size: 14)!))
                            .opacity(0.8)
                        Rectangle()
                            
                            .frame(height: 1)
                    }.foregroundColor(.white)
                    CircleProgress2(progress: 0)
                }.padding()
                
            }.padding()
        }.clipShape(RoundedRectangle(cornerRadius: 25.0))
        .frame(width: UIScreen.main.bounds.width - 32,
               height: UIScreen.main.bounds.height / 3)
        .shadow(color: .black, radius: 5)
        
}
}

struct LevelProgressView2_Previews: PreviewProvider {
    static var previews: some View {
        LevelProgressView()
    }
}

struct CircleProgress2: View {
    
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
