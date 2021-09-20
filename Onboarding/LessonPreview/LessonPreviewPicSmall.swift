//
//  LessonPreviewSmall.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 08.09.2021.
//

import SwiftUI

struct LessonPreviewPicSmall: View {
    var body: some View {
        ZStack {
            Image("videoPrevImg")
                .resizable()
                .clipShape(RoundedCustomCornersShape(cornerRadius: 28, style: .circular))
                .frame(width: 128, height: 118)
                .foregroundColor(.red)
            
            //PlayButton
            Image(systemName: "play.circle.fill")
                .resizable()
                .foregroundColor(Color("playButtonColor"))
                .background(Color.white).clipShape(Circle())
                .frame(width: 39, height: 39)
        }
    }
}

struct RoundedCustomCornersShape: Shape {

    var cornerRadius: CGFloat
    var style: RoundedCornerStyle

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        return Path(path.cgPath)
    }
}
