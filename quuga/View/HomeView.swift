//
//  HomeView.swift
//  quuga
//
//  Created by 西岡 on 2026/01/12.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack{
            SwipingVideoPlayerBehavior()
            VStack {
                Spacer()
                Navigator()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    HomeView()
}
