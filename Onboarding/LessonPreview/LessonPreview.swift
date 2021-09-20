//
//  LessonPreview.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 02.09.2021.
//

import SwiftUI

struct LessonPreview: View {
    
    let index: Int
    @ObservedObject var progress: CurrentProgress
    
    var body: some View {
        
        let durationMin = Utility.formatSecondsToHMS(lessons[index].duration)
            .components(separatedBy: ":")[0]
        let durationSec = Utility.formatSecondsToHMS(lessons[index].duration)
            .components(separatedBy: ":")[1]
        
        ZStack {
            RoundedRectangle(cornerRadius: 28)
                .frame(width: 336, height: 118)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.2), radius: 12, x: 0.0, y: 12.5)
            HStack {
                
                LessonPreviewPicSmall()
                
                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Lezione 0\(lessons[index].lesson)")
                            .font(Font(UIFont(name: "SFUIDisplay-Medium", size: 18)!))
                            .foregroundColor(.black)
                        
                        Text("Principiante")
                            .font(Font(UIFont(name: "SFUIDisplay-Light", size: 14)!))
                            .foregroundColor(Color("lessonNameColor"))
                        
                        HStack {
                            Text("\(Image(systemName: "alarm.fill")) \(durationMin) min \(durationSec) sec")
                                .font(Font(UIFont(name: "SFUIDisplay-Medium", size: 12)!))
                                .foregroundColor(Color("lessonTimeColor"))
                        }
                    }
                    
                    LessonPreviewProgressView(index: index, progress: progress)
                    
                }.frame(width: 201, height: 118)
            }.frame(width: 336, height: 118)
        }.onAppear {
            progress.refreshProgress(index: index)
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 15)
    }
}

struct LessonPreview_Previews: PreviewProvider {
    static var previews: some View {
        LessonPreview(index: 1, progress: CurrentProgress(lessons: lessons))
    }
}




