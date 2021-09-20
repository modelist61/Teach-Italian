//
//  PlayerControlsView.swift
//  Onboarding
//
//  Created by Dmitry Tokarev on 13.09.2021.
//

import SwiftUI
import Combine
import AVFoundation

struct AudioPlayerControlsView: View {
//    let index: Int
//    @ObservedObject var progress: CurrentProgress

    
    let player: AVPlayer
    let timeObserver: PlayerTimeObserver
    let durationObserver: PlayerDurationObserver
    let itemObserver: PlayerItemObserver
    @State private var currentTime: TimeInterval = 0
    @State private var currentDuration: TimeInterval = 0
    let durationPreLoad: Double
    
    var body: some View {
//        let currentTime2 = progress.currentProgressSeconds[index]
        VStack {
            ProgressView(value: currentTime, total: currentDuration)
                .progressViewStyle(PlayerProgressViewStyle(duration: currentDuration, time: currentTime))
        }
        .onReceive(timeObserver.publisher) { time in //2
                self.currentTime = time
//            print("timeObserver.publisher \(time)")
        }
        
        .onReceive(durationObserver.publisher) { duration in //3
            self.currentDuration = duration.rounded()
//            print("durationObserver.publisher \(duration)")

        }
        
        .onReceive(itemObserver.publisher) { hasItem in //1
            self.currentTime = 0
            self.currentDuration = durationPreLoad
//            print("itemObserver.publisher \(hasItem)")

        }
    }
}


class PlayerTimeObserver {
    let publisher = PassthroughSubject<TimeInterval, Never>()
    private weak var player: AVPlayer?
    private var timeObservation: Any?
    private var paused = false
    
    init(player: AVPlayer) {
        self.player = player
        
        timeObservation = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.5,
                                                                             preferredTimescale: 600),
                                                         queue: nil) { [weak self] time in
            guard let self = self else { return }
            guard !self.paused else { return }
            self.publisher.send(time.seconds)
        }
    }
    
    deinit {
        if let player = player,
           let observer = timeObservation {
            player.removeTimeObserver(observer)
        }
    }
    
    func pause(_ pause: Bool) {
        paused = pause
    }
}

class PlayerItemObserver {
    let publisher = PassthroughSubject<Bool, Never>()
    private var itemObservation: NSKeyValueObservation?
    
    init(player: AVPlayer) {
        itemObservation = player.observe(\.currentItem) { [weak self] player, change in
            guard let self = self else { return }
            self.publisher.send(player.currentItem != nil)
        }
    }
    
    deinit {
        if let observer = itemObservation {
            observer.invalidate()
        }
    }
}

class PlayerDurationObserver {
    let publisher = PassthroughSubject<TimeInterval, Never>()
    private var cancellable: AnyCancellable?
    
    init(player: AVPlayer) {
        let durationKeyPath: KeyPath<AVPlayer, CMTime?> = \.currentItem?.duration
        cancellable = player.publisher(for: durationKeyPath).sink { duration in
            guard let duration = duration else { return }
            guard duration.isNumeric else { return }
            self.publisher.send(duration.seconds)
        }
    }
    
    deinit {
        cancellable?.cancel()
    }
}
