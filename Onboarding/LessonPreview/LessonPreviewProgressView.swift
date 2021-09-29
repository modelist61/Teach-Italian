//
//  LessonPreviewProgressView.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 08.09.2021.
//

import SwiftUI

struct LessonPreviewProgressView: View {
    
    let index: Int
    @EnvironmentObject var progress: CurrentProgress
    
    var body: some View {
        let intProgress = progress.savingProgressPersent[index]
        
        VStack(alignment: .leading, spacing: 8) {
//            Text("\(intProgress) % progresso")
            Text(String(intProgress) + " % progresso".localized())
                .font(Font(UIFont(name: "SFUIDisplay-Regular", size: 14)!))
                .foregroundColor(Color("lessonPercentColor"))
                .padding(.bottom, -5)
            ProgressView(value: CGFloat(intProgress), total: 100)
                .progressViewStyle(RoundedRectProgressViewStyle())
        }.animation(.easeIn)
    }
}

struct RoundedRectProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 161, height: 6)
                .foregroundColor(Color("lessonProgressViewColor2"))
                .overlay(RoundedRectangle(cornerRadius: 20).stroke().foregroundColor(Color("lessonProgressViewColor3")))

                RoundedRectangle(cornerRadius: 20)
                    .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * 161, height: 6)
                    .foregroundColor(Color("lessonProgressViewColor1"))
        }
    }
}
