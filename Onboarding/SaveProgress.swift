//
//  SaveProgress.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 10.09.2021.
//

import Foundation
import AVFoundation
//import Combine

struct AudioPlayer {
    let player = AVPlayer()
    let item: AVPlayerItem
    let savingTime: Double
    
    
}

final class CurrentProgress: ObservableObject {
    let lessonList: [LessonUrl]
    let player = AVPlayer()

    @Published var currentProgressSeconds: [Double]
    @Published var savingProgressPersent: [Int]
    @Published var allLessonsDuration: [Double] = []
//    @Published var currentSecondItem = 0.0
    
//    init(secondsArray: [Double], percentArray: [Int]) {
//        self.currentProgressSeconds = secondsArray
//        self.savingProgressPersent = percentArray
//    }
    
    init(lessons: [LessonUrl]) {
        self.lessonList = lessons
        self.currentProgressSeconds = Array(repeating: 0, count: lessonList.count)
        self.savingProgressPersent = Array(repeating: 0, count: lessons.count)
    }
    
    func calcAverageLevelPercent() -> Int {
        savingProgressPersent.reduce(0, +) / savingProgressPersent.count
    }
    
    func refreshProgress(index: Int) {
        savingProgressPersent[index] = calcCurrentPersent(seconds: currentProgressSeconds[index], index: index)
    }
    
    func updateSaving() {
        currentProgressSeconds = udCheckIsNil(udKey: "progress")
    }
    
    func writeSavingToUD() {
        UserDefaults.standard.set(currentProgressSeconds, forKey: "progress")
    }
    
    func calcPercentAtLevel(array: [Int]) -> Int {
        var summ = 0
        for lesson in array {
            summ += lesson
        }
        return summ / array.count
    }
    
    func updateDuration() {
        for lesson in lessonList {
            allLessonsDuration.append(lesson.duration)
        }
    }
    
    private func udCheckIsNil(udKey: String) -> [Double] {
            let defaults = UserDefaults.standard
            if(defaults.array(forKey: udKey) != nil) {
                return defaults.array(forKey: udKey) as! [Double]
            } else {
                //MAKE DEFAULT 0.0 ARRAY
                var seconds: [Double] = []
                for _ in lessons.indices {
                    seconds.append(0.0)
                }
                return seconds
            }
    }
    
    private func calcCurrentPersent(seconds: Double, index: Int) -> Int {
        Int((seconds / (Double(lessonList[index].duration) / 100)).rounded())
    }
}
