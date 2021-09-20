//
//  OnBoardView.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 31.08.2021.
//

import SwiftUI

struct OnBoardView: View {
    
    @Binding var isPresening: Bool
    @State private var index = 0
    
    var body: some View {
        ZStack {
            Color("onboardingBackgroundColor").ignoresSafeArea()
            VStack {
                OnBoardTabView(selection: $index)
                OnBoardCarousel(index: $index)
                    .padding(.bottom, 32)
                OnBoardButton(selection: $index, dismiss: $isPresening)
                    .padding(.bottom, 22)
            }
        }
//        .transition(.move(edge: .bottom))
    }
}

struct OnBoardView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardView(isPresening: Binding.constant(true))
    }
}
