//
//  VideoPlaybackController.swift
//  quuga
//
//  Created by 西岡 on 2026/01/12.
//

import Foundation
import AVFoundation
import Combine

final class VideoPlaybackController: ObservableObject {
    
    @Published private(set) var isPlaying = false

    private var player: AVPlayer?
    private var currentVideoID: String?

    func play(videoID: String, url: URL) {
        if currentVideoID != videoID {
            stop()
            player = AVPlayer(url: url)
            if (player !== nil) {
                player?.play()
                currentVideoID = videoID
                isPlaying = true
            }
            else {
                // todo: ここでエラーの場合にエラー処理を入れたい
            }
        }
    }

    func pause() {
        player?.pause()
        isPlaying = false
    }

    func stop() {
        player?.pause()
        player = nil
        currentVideoID = nil
        isPlaying = false
    }
    
    func toggle() {
        guard player != nil else { return }
        player?.timeControlStatus == .playing ? pause() : player?.play()
    }

    func attach(to layer: AVPlayerLayer) {
        layer.player = player // 現在表示しているものを表示する
        layer.videoGravity = .resizeAspectFill // 全画面表示！！
    }
}
