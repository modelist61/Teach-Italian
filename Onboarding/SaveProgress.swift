//
//  SaveProgress.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 10.09.2021.
//

import Foundation
import AVFoundation
import Combine

//class AudioPlayer {
//    internal init(item: AVPlayerItem, durationObserver: PlayerDurationObserver) {
//        self.item = item
//        self.durationObserver = durationObserver
//    }
//    
////    let player: AVPlayer
//    let item: AVPlayerItem
//    let durationObserver: PlayerDurationObserver
//    
//    
//}

final class CurrentProgress: ObservableObject {
    let lessonList: [LessonUrl]
    let player = AVPlayer()
    
    @Published var currentProgressSeconds: [Double]
    @Published var savingProgressPersent: [Int]
    @Published var allLessonsDuration: [Double]
    @Published var allLessonsItem: [AVPlayerItem] = []
    
    init(lessons: [LessonUrl]) {
        self.lessonList = lessons
        self.currentProgressSeconds = Array(repeating: 0, count: lessonList.count)
        self.savingProgressPersent = Array(repeating: 0, count: lessonList.count)
        self.allLessonsDuration = Array(repeating: 0, count: lessonList.count)
    }
    
    func checItemUrl() {
        var playerArray: [AVPlayerItem] = []
        
        for index in lessonList.indices {
            guard let url = URL(string: lessonList[index].url) else { return }
            let playerItem = AVPlayerItem(url: url)
            playerArray.append(playerItem)
//            print("CHECK ITEMS \(index) \(url)")
            
        }
        allLessonsItem = playerArray
//        print("itemsArray \(playerArray)")
    }
    
    func fetchDurations() {
        DispatchQueue.global(qos: .utility).async {
        if UserDefaults.standard.array(forKey: "fetchDuration") == nil {
            var tempDuration: [Double] = []
            for itemLesson in self.allLessonsItem {
                if itemLesson.status != .failed {
                    let duration = itemLesson.asset.duration.seconds
                    if duration < 1 {
                        tempDuration.append(Double(1.0))
                    } else {
                    tempDuration.append(Double(duration))
                    }
                    print("PreDuration = \(duration)")
                }
            }
            print(tempDuration)
            
            UserDefaults.standard.set(tempDuration, forKey: "fetchDuration")
            DispatchQueue.main.async {
                self.allLessonsDuration = tempDuration
            }
        } else {
            guard let fetch = UserDefaults.standard.array(forKey: "fetchDuration") else { return }
            DispatchQueue.main.async {
                self.allLessonsDuration = fetch as! [Double]
//                print("CHECK MAIN \(Thread.isMainThread)")
                print("load fetchDuration from UD \(self.allLessonsDuration)")
            }
        }
        }
    }
    
    func calcAverageLevelPercent() -> Int {
        savingProgressPersent.reduce(0, +) / savingProgressPersent.count
    }
    
    
    
    func updateSaving(udKey: String) {
            self.currentProgressSeconds = self.udCheckIsNil(udKey: udKey)
        
//        DispatchQueue.global(qos: .userInteractive).async {
//        let defaults = UserDefaults.standard
//        if(defaults.array(forKey: "progress") != nil) {
//            DispatchQueue.main.async {
//                self.currentProgressSeconds = defaults.array(forKey: "progress") as! [Double]
//            }
//        } else {
//            //MAKE DEFAULT 0.0 ARRAY
//            var seconds: [Double] = []
//            for _ in lessons.indices {
//                seconds.append(0.0)
//            }
//            DispatchQueue.main.async {
//                self.currentProgressSeconds = seconds
//            }
//        }
//        }
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
    
    func refreshProgress(index: Int) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let fetch = UserDefaults.standard.array(forKey: "fetchDuration") else { return }
//            print("fetch in calc \(fetch)")//
//            let checkedFetch: [Double] = []
//            for dur in fetch {
//                if dur < 1.0 {
//                    checkedFetch.append(Double(0.0))
//                } else {
//                    checkedFetch.append(Double(dur))
//                }
//            }
            let percent = Int((self.currentProgressSeconds[index] / (fetch[index] as! Double / 100)).rounded())
            DispatchQueue.main.async {
                self.savingProgressPersent[index] = percent
            }
        }
    }
}
