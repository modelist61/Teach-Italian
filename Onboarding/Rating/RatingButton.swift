//
//  RatingButton.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 02.09.2021.
//

import SwiftUI
import StoreKit

struct RatingButton: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 272, height: 64)
                .foregroundColor(Color("ratingButtonColor"))
            Text("Stima")
                .font(Font(UIFont(name: "SFProRounded-Semibold", size: 20)!))
                .foregroundColor(.white)
        }.onTapGesture {
            if let windowScene = UIApplication.shared.windows.first?.windowScene { SKStoreReviewController.requestReview(in: windowScene) }
        }
    }
}


struct RatingButton_Previews: PreviewProvider {
    static var previews: some View {
        RatingButton()
    }
}
