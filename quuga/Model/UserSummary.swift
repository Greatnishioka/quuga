//
//  UserSummary.swift
//  quuga
//
//  Created by 西岡 on 2026/01/12.
//

import Foundation

// イメージとしては動画の所有者情報ってイメージだったけど、ユーザーページのモデルとしても運用してもいいかも
struct UserSummary: Identifiable, Equatable {
    let id: String
    let name: String
    let avatarURL: URL?
}
