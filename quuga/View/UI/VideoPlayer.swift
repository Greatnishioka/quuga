//
//  VideoPlayer.swift
//  quuga
//
//  Created by 西岡 on 2026/01/12.
//

import SwiftUI
import AVFoundation

private final class PlayerContainerView: UIView {
    override static var layerClass: AnyClass {
        AVPlayerLayer.self
    }

    var playerLayer: AVPlayerLayer {
        layer as! AVPlayerLayer
    }
}

private struct VideoPlayerLayerView: UIViewRepresentable {
    @ObservedObject var playbackController: VideoPlaybackController

    func makeUIView(context: Context) -> PlayerContainerView {
        PlayerContainerView()
    }

    func updateUIView(_ uiView: PlayerContainerView, context: Context) {
        playbackController.attach(to: uiView.playerLayer)
    }
}

struct SwipingVideoPlayerBehavior: View {
    @StateObject private var viewModel = SwipingVideoPlayerViewModel()
    @StateObject private var playbackController = VideoPlaybackController()

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.videos) { video in
                    ZStack {
                        VideoPlayerLayerView(playbackController: playbackController)
                            .containerRelativeFrame([.horizontal, .vertical])
                            .background(.black)

                        VStack(spacing: 12) {
                            Text(video.title ?? "Untitled")
                                .font(.title)
                                .bold()

                            Text(video.videoURL.absoluteString)
                                .font(.footnote)
                                .foregroundStyle(.white.opacity(0.8))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 24)
                        }
                    }
                    .onAppear {
                        playbackController.play(videoID: video.id, url: video.videoURL)
                    }
                    .onDisappear {
                        if playbackController.isPlaying {
                            playbackController.pause()
                        }
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.paging)
        .ignoresSafeArea()
        .task {
            await viewModel.loadVideos()
        }
        .overlay(alignment: .top) {
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .font(.callout)
                    .foregroundStyle(.white)
                    .padding(12)
                    .background(.red.opacity(0.8))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.top, 16)
            }
        }
    }
    // loadVideos moved to ViewModel
}

#Preview {
    SwipingVideoPlayerBehavior()
}
