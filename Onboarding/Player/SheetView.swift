//
//  SheetView.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 11.09.2021.
//

import SwiftUI

struct SheetView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("onboardingBackgroundColor"), Color.green, Color.blue]), startPoint: .top, endPoint: .bottomLeading).ignoresSafeArea()
            VStack {
                RoundedRectangle(cornerRadius: 100)
                    .frame(width: 134, height: 5, alignment: .center)
                    .padding()
                Spacer()
                Text("Don't toch me yet!")
                    .font(.system(size: 30))
                Text("😡")
                    .font(.system(size: 130))
                Spacer()
                EmptyView()
            }
        }
//        Button("Press to dismiss") {
//            presentationMode.wrappedValue.dismiss()
//                }
//                .font(.title)
//                .padding()
//                .background(Color.black)
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView()
    }
}
