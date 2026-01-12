//
//  VideoPlayer.swift
//  quuga
//
//  Created by 西岡 on 2026/01/12.
//

import SwiftUI

struct SwipingVideoPlayerBehavior: View {

    struct Video: Identifiable {
        let id: Int
    }

    @State private var videos: [Video] =
        (0..<10).map { Video(id: $0) }
    @State private var isLoading = false

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                ForEach(videos) { video in
                    ZStack {
                        Rectangle()
                            .fill(Color.blue.opacity(0.6))
                            .containerRelativeFrame([.horizontal, .vertical])

                        Text("Video \(video.id + 1)")
                            .font(.title)
                            .bold()
                    }
                    .onAppear {
                        if video.id == videos.last?.id {
                            loadMore()
                        }
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.paging)
        .ignoresSafeArea()
    }

    // 数の上限が来たら追加する感じにする
    private func loadMore() {
        guard !isLoading else { return }
        isLoading = true
        
        defer { isLoading = false }
        
        // 一旦とりあえずダミー的な通信っぽいやつを入れとく
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let nextId = videos.count
            let newVideos = (nextId..<nextId+10)
                .map { Video(id: $0) }

            videos.append(contentsOf: newVideos)
        }
    }
}

#Preview {
    SwipingVideoPlayerBehavior()
}
