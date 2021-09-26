//
//  LessonUrl.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 07.09.2021.
//

import Foundation
import AVFoundation


struct LessonUrl {
    let level: Int
//    let lesson: Int
    let url: String
//    let duration: Double //DELETE
}

let lessons = [
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/1.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/2.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/3.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/4.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/5.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/6.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/7.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/8.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/9.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/10.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/11.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/12.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/13.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/14.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/15.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/16.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/17.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/18.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/19.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/20.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/21.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/22.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/23.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/24.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/25.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/26.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/27.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/28.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/29.mp3"),
    LessonUrl(level: 01, url: "https://englishforlesson.space//Italian/level1/30.mp3")
]

//class LessonItem {
//    internal init(player: AVPlayer, lesson: LessonUrl) {
//        self.player = player
//        self.lesson = lesson
//    }
//    
//    let player: AVPlayer
//    let lesson: LessonUrl
//    
//    func checkUrl() {
//        
//        guard let url = URL(string: lesson.url) else { return }
//        let playerItem = AVPlayerItem(url: url)
//    }
//}
