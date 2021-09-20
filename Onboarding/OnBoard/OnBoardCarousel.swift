//
//  OnBoardCarousel.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 01.09.2021.
//

import SwiftUI

struct OnBoardCarousel: View {
    
    @Binding var index: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach((0..<tabs.count), id: \.self) { index in
                Circle()
                    .fill(index == self.index ? Color.white : Color.white.opacity(0.4))
                    .frame(width: index == self.index ? 12 : 8, height: index == self.index ? 12 : 8)
                    .animation(.easeIn)
            }
        }
        
    }
}

struct OnBoardCarousel_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("onboardingBackgroundColor").ignoresSafeArea()
            OnBoardCarousel(index: Binding.constant(0))
        }
    }
}
