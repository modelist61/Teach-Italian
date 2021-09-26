//
//  LunchScreen.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 25.09.2021.
//

import SwiftUI

struct LunchScreen: View {
    
    @State var degrees: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color("onboardingBackgroundColor")
                .ignoresSafeArea()
            VStack(spacing: 90) {
                
            Image("videoPrevImg")
                .resizable()
                .frame(width: 335, height: 335)
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .rotation3DEffect(Angle.degrees(degrees), axis: (x: 90, y: 180, z: 0))
                .shadow(radius: 5)

                Text("Wellcome!")
                    .foregroundColor(Color("lessonProgressViewColor1"))
                    .font(Font(UIFont(name: "SFProRounded-Semibold", size: 30)!))
            }

        }.onAppear {
            withAnimation(Animation.easeOut(duration: 2)) {
                degrees = 360
            }
        }
    }
}

struct LunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LunchScreen()
    }
}
