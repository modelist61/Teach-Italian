//
//  OnBoardButton.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 31.08.2021.
//

import SwiftUI

struct OnBoardButton: View {
    
    @Binding var selection: Int
    @Binding var dismiss: Bool
//    let buttonLable = ["Continue", "Permettere"]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 340, height: 64, alignment: .center)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.15), radius: 15, x: 0.0, y: 5)
            Text(selection < tabs.count - 1 ? "Continue" : "Permettere")
                .font(Font(UIFont(name: "SFProRounded-Semibold", size: 24)!))
                .foregroundColor(.black)
        }
        .onTapGesture {
            buttonAction()
        }
    }
    
    private func buttonAction() {
        withAnimation {
             selection += 1
            if selection > tabs.count - 1 {
                dismiss = false
            }
        }
        
    }
}

struct OnBoardButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("onboardingBackgroundColor").ignoresSafeArea()
            OnBoardButton(selection: Binding.constant(1), dismiss: Binding.constant(true))
        }
    }
}
