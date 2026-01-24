//
//  VideoPlayer.swift
//  quuga
//
//  Created by 西岡 on 2026/01/12.
//

import SwiftUI
import AVFoundation

private struct DemoVideosResponse: Decodable {
    struct Payload: Decodable {
        let videos: [DemoVideo]
    }

    let status: Int
    let data: Payload
}

private struct DemoVideo: Identifiable, Decodable, Equatable {
    let id: String
    let title: String
    let url: URL
}

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
    @State private var videos: [Video] = []
    @State private var isLoading = false
    @State private var errorMessage: String?
    @StateObject private var playbackController = VideoPlaybackController()

    private let endpoint = URL(string: "https://quuga-be.nishiokaayato-6e8.workers.dev/demo_videos")!

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                ForEach(videos) { video in
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
            await loadVideos()
        }
        .overlay(alignment: .top) {
            if let errorMessage {
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

    @MainActor
    private func loadVideos() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil

        defer { isLoading = false }

        do {
            // fetchを行なっている
            let (data, response) = try await URLSession.shared.data(from: endpoint)

            // ここは200だけしか判定しないようにする
            guard let http = response as? HTTPURLResponse,
                  (200..<300).contains(http.statusCode) else {
                throw URLError(.badServerResponse)
            }

            let decoded = try JSONDecoder().decode(DemoVideosResponse.self, from: data)
            let now = Date()
            let author = UserSummary(id: "demo", name: "Demo", avatarURL: nil)
            videos = decoded.data.videos.map { demoVideo in
                Video(
                    id: demoVideo.id,
                    videoURL: demoVideo.url,
                    duration: 0,
                    aspectRatio: 9.0 / 16.0,
                    author: author,
                    title: demoVideo.title,
                    description: nil,
                    createdAt: now,
                    viewCount: 0,
                    likeCount: 0,
                    isLiked: false,
                    templateID: nil,
                    isProVideo: false
                )
            }
        } catch {
            errorMessage = "動画の取得に失敗しました。"
        }
    }
}

#Preview {
    SwipingVideoPlayerBehavior()
}
