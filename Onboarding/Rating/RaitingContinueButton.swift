//
//  RaitingButton.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 01.09.2021.
//

import SwiftUI

struct RaitingContinueButton: View {
    
    @Binding var dismiss: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 340, height: 64, alignment: .center)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.15), radius: 15, x: 0.0, y: 5)
            Text("Continue")
                .font(Font(UIFont(name: "SFProRounded-Semibold", size: 24)!))
                .foregroundColor(.black)
        }.onTapGesture {
            dismiss = false
        }
    }
}

struct RaitingButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("onboardingBackgroundColor").ignoresSafeArea()
            RaitingContinueButton(dismiss: Binding.constant(true))
        }
    }
}
