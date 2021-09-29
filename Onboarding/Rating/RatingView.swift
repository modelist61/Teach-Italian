//
//  RaitingView.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 01.09.2021.
//

import SwiftUI
//import StoreKit

struct RaitingView: View {
    
    @Binding var dismiss: Bool
    
    var body: some View {
        ZStack {
            Color("onboardingBackgroundColor").ignoresSafeArea()
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 21)
                        .frame(width: 335, height: 518)
                        .foregroundColor(.white)
                        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0.0, y: 4)
                    VStack {
                        RatingHeadText()
                        
                        RatingStarsStack()
                            .padding(.bottom, 28)
                        RatingPreview()
                            .padding(.bottom, 40)
                        RatingButton()
                        
                    }.frame(width: 335, height: 518, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }.padding(.top, 50)
                Spacer()
                RaitingContinueButton(dismiss: $dismiss)
            }
        }
    }
    
}

struct RaitingView_Previews: PreviewProvider {
    static var previews: some View {
        RaitingView(dismiss: Binding.constant(true))
    }
}






