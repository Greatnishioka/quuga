//
//  SwipingVideoPlayerViewModel.swift
//  quuga
//
//  Created by GitHub Copilot on behalf of user.
//

import Foundation
import Combine

struct DemoVideosResponse: Decodable {
    struct Payload: Decodable {
        let videos: [DemoVideo]
    }

    let status: Int
    let data: Payload
}

struct DemoVideo: Identifiable, Decodable, Equatable {
    let id: String
    let title: String
    let url: URL
}

@MainActor
final class SwipingVideoPlayerViewModel: ObservableObject {
    @Published var videos: [Video] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let endpoint = URL(string: "https://quuga-be.nishiokaayato-6e8.workers.dev/demo_videos")!

    func loadVideos() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil

        defer { isLoading = false }

        do {
            let (data, response) = try await URLSession.shared.data(from: endpoint)

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
