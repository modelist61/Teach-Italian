//
//  RatingPreview.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 02.09.2021.
//

import SwiftUI

struct RatingPreview: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 11)
                .frame(width: 243, height: 127)
                .foregroundColor(.white)
                .shadow(color: Color.black.opacity(0.08), radius: 27, x: 0.0, y: 4)
            
            HStack(alignment: .top, spacing: 10) {
                Image("imgRatingFoto")
                    .resizable()
                    .frame(width: 62, height: 62)
                VStack(alignment: .leading, spacing: 5) {
                    Text("Max R.")
                        .font(Font(UIFont(name: "SFProRounded-Semibold", size: 16)!))
                        .padding(.vertical, 5)
                    Text("Mi è piaciuta molto \n l'applicazione, tutto è \n accessibile e semplice")
                        .font(Font(UIFont(name: "SFProRounded-Semibold", size: 13)!))
                }.foregroundColor(.black)
            }
        }
    }
}

struct RatingPreview_Previews: PreviewProvider {
    static var previews: some View {
        RatingPreview()
    }
}
