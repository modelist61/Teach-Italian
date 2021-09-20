//
//  RatingHeadText.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 01.09.2021.
//

import SwiftUI

struct RatingHeadText: View {
    var body: some View {
        VStack(spacing: 25) {
            Text("Puoi aiutarci ad essere \n ancora migliori")
                .font(Font(UIFont(name: "SFProRounded-Semibold", size: 24)!))
                .multilineTextAlignment(.center)
            
            
            Text("Si prega di valutare la nostra app. \n Questo ci motiva a sviluppare un \n prodotto elegante e di alta qualità.")
                .font(Font(UIFont(name: "SFProRounded-Semibold", size: 14)!))
                .padding(.bottom, 26)
        }.foregroundColor(.black)
    }
}

struct RatingHeadText_Previews: PreviewProvider {
    static var previews: some View {
        RatingHeadText()
    }
}
