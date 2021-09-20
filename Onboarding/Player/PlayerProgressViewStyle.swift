//
//  PlayerProgressViewStyle.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 13.09.2021.
//

import SwiftUI

struct PlayerProgressViewStyle: ProgressViewStyle {
    
    let duration: TimeInterval
    let time: TimeInterval
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 335, height: 5)
                    .foregroundColor(.white.opacity(0.2))
                HStack(alignment: .center) {
                    Text("\(Utility.formatSecondsToHMS(time))")
                        .offset(x: -10)
                    Spacer()
                    Text("\(Utility.formatSecondsToHMS(duration))")
                }.frame(width: 335)
                .font(Font(UIFont(name: "SFUIDisplay-Regular", size: 14)!))
                .foregroundColor(.white.opacity(0.6))
                .offset(y: 20)
            }
            
            HStack() {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * 335, height: 5)
                    .foregroundColor(.white)
                ZStack {
                    Circle()
                        .frame(width: 14, height: 14, alignment: .trailing)
                        .foregroundColor(.white)
                    
                    Text("")
                        .font(Font(UIFont(name: "SFUIDisplay-Regular", size: 14)!))
                        .foregroundColor(.white)
                        .offset(y: 20)
                }
                .offset(x: -20)
            }
        }
    }
}
