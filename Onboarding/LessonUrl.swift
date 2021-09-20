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
    let lesson: Int
    let url: String
    let duration: Double
}

let lessons = [
    LessonUrl(level: 01, lesson: 01, url: "https://englishforlesson.space//Italian/level1/1.mp3", duration: 1653),
    LessonUrl(level: 01, lesson: 02, url: "https://englishforlesson.space//Italian/level1/2.mp3", duration: 1668),
    LessonUrl(level: 01, lesson: 03, url: "https://englishforlesson.space//Italian/level1/3.mp3", duration: 1689),
    LessonUrl(level: 01, lesson: 04, url: "https://englishforlesson.space//Italian/level1/4.mp3", duration: 1721),
    LessonUrl(level: 01, lesson: 05, url: "https://englishforlesson.space//Italian/level1/5.mp3", duration: 1770),
    LessonUrl(level: 01, lesson: 06, url: "https://englishforlesson.space//Italian/level1/6.mp3", duration: 1719),
    LessonUrl(level: 01, lesson: 07, url: "https://englishforlesson.space//Italian/level1/7.mp3", duration: 1707),
    LessonUrl(level: 01, lesson: 08, url: "https://englishforlesson.space//Italian/level1/8.mp3", duration: 1692),
    LessonUrl(level: 01, lesson: 09, url: "https://englishforlesson.space//Italian/level1/9.mp3", duration: 1790),
    LessonUrl(level: 01, lesson: 10, url: "https://englishforlesson.space//Italian/level1/10.mp3", duration: 1705)
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
