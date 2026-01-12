//
//  Strip.swift
//  quuga
//
//  Created by 西岡 on 2026/01/10.
//

import SwiftUI

public struct StripesConfig {
    var background: Color
    var foreground: Color
    var degrees: Double
    var barWidth: CGFloat
    var barSpacing: CGFloat

    public init(background: Color = Color.clear, foreground: Color =
                Color("MainGreen"), // カラーの情報
                degrees: Double = 45, // 回転角度
                barWidth: CGFloat = AppConfig.UI.border.thin, // バーの細さ。動的にしたいね
                barSpacing: CGFloat = 3 // 背景の白い部分の幅
    ) {
        self.background = background
        self.foreground = foreground
        self.degrees = degrees
        self.barWidth = barWidth
        self.barSpacing = barSpacing
    }
}

public struct Stripe: View {
    var config: StripesConfig

    public init(config: StripesConfig = StripesConfig()) {
        self.config = config
    }

    public var body: some View {
        GeometryReader { geometry in
            let longSide = max(geometry.size.width, geometry.size.height)
            let itemWidth = config.barWidth + config.barSpacing
            let items = Int(2 * longSide / itemWidth)
            HStack(spacing: config.barSpacing) {
                ForEach(0..<items, id: \.self) { index in
                    config.foreground
                        .frame(width: config.barWidth, height: 2 * longSide)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .rotationEffect(Angle(degrees: config.degrees), anchor: .center)
            .offset(x: -longSide / 2, y: -longSide / 2)
            .background(config.background)
        }
        .clipped()
    }
}

#Preview {
    Stripe()
}
