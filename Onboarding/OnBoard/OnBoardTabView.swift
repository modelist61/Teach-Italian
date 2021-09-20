//
//  OnBoardScreens.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 27.08.2021.
//

import SwiftUI

struct OnBoardTabView: View {
    
    @Binding var selection: Int
    
    var body: some View {
        let yExtension: CGFloat = 65
        ZStack {
            GeometryReader { gr in
                TabView(selection: $selection) {
                    ForEach(tabs.indices, id: \.self) { index in
                        OnBoardPage(index: index)
                            .frame(width: gr.size.width,
                                   height: gr.size.height + yExtension,
                                   alignment: .top)
//                            .background(Color.blue)
                    }
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
            }.offset(y: -yExtension)
        }
    }
}

struct OnBoardScreens_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("onboardingBackgroundColor").ignoresSafeArea()
            OnBoardTabView(selection: Binding.constant(3))
        }
    }
}
