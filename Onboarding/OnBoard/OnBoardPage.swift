//
//  OnBoardView.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 27.08.2021.
//

import SwiftUI

struct OnBoardPage: View {
    
    let index: Int
    
    var body: some View {
        GeometryReader { gr in
            let height = gr.size.height
//            let width = gr.size.width
            VStack {
                VStack {
                    if index == 0 {
                        Image("img1Header")
                            .resizable()
                            .scaledToFit()
                    } else if index == 6 {
                        Image("img7Header")
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContainerRelativeShape()
                            .foregroundColor(.clear)
                    }
                }.frame(height: height / 7)
                VStack {
                    HStack(alignment: .center) {
                        Image(tabs[index].image)
                            .resizable()
                            .scaledToFit()
                    }.frame(height: height / 2 - 65)
                    VStack(spacing: 16) {
                        Text(tabs[index].title)
                            .font(Font(UIFont(name: "SFProRounded-Semibold", size: index == 6 ? 28 : 24)!))
                        
                        Text(tabs[index].text)
                            .font(Font(UIFont(name: "SFProRounded-Semibold", size: index == 6 ? 24 : 18)!))
                        
                    }.multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.top, index == 0 ? 50 : 10)
                    
                }
            }.edgesIgnoringSafeArea(.top)
        }
    }
}

struct OnoboardingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ZStack {
                Color("onboardingBackgroundColor").ignoresSafeArea()
                VStack {
                    OnBoardPage(index: 0)
                    Spacer()
                    EmptyView()
                }
            }
        }
    }
}

