//
//  Video.swift
//  quuga
//
//  Created by 西岡 on 2026/01/12.
//

import Foundation

struct Video: Identifiable, Equatable {
    let id: String

    // 再生
    let videoURL: URL
    let duration: Double   // seconds
    let aspectRatio: CGFloat

    // 投稿者
    let author: UserSummary

    // コンテンツ情報
    let title: String?
    let description: String?

    // メタ
    let createdAt: Date
    let viewCount: Int
    let likeCount: Int
    let isLiked: Bool

    // 歌唱SNS向け
    let templateID: String?
    let isProVideo: Bool
}
