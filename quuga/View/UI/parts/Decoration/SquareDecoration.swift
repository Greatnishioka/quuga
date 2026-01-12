//
//  SwiftUIView.swift
//  quuga
//
//  Created by 西岡 on 2026/01/12.
//

import SwiftUI

struct SquareDecoration: View {
    var hasTopLeft: Bool = true
    var hasTopRight: Bool = true
    var hasBottomLeft: Bool = true
    var hasBottomRight: Bool = true
    var shapeSize: CGFloat = 10.0
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack() {
                HStack(spacing: 0) {
                    
                    if (hasTopLeft) {
                        Rectangle()
                            .stroke(Color("MainGreen"), lineWidth: AppConfig.UI.border.thin)
                            .frame(width: shapeSize, height: shapeSize)
                            .clipShape(
                                Rectangle()
                                    .offset(x: shapeSize / 2, y: shapeSize / 2)
                            )
                            .offset(x: -shapeSize / 2, y: 0)
                    }
                    Spacer()
                    if (hasTopRight) {
                        Rectangle()
                            .stroke(Color("MainGreen"), lineWidth: AppConfig.UI.border.thin)
                            .frame(width: shapeSize, height: shapeSize)
                            .clipShape(
                                Rectangle()
                                    .offset(x: -shapeSize / 2, y: shapeSize / 2)
                            )
                            .offset(x: shapeSize / 2, y: 0)
                    }
                }.offset(x: 0, y: -shapeSize / 2)
                if hasTopLeft || hasTopRight { Spacer() }
                HStack(spacing: 0) {
                    if (hasBottomLeft) {
                        Rectangle()
                            .stroke(Color("MainGreen"), lineWidth: AppConfig.UI.border.thin)
                            .frame(width: shapeSize, height: shapeSize)
                            .clipShape(
                                Rectangle()
                                    .offset(x: shapeSize / 2, y: -shapeSize / 2)
                            )
                            .offset(x: -shapeSize / 2, y: 0)
                    }
                    Spacer()
                    if (hasBottomRight) {
                        Rectangle()
                            .stroke(Color("MainGreen"), lineWidth: AppConfig.UI.border.thin)
                            .frame(width: shapeSize, height: shapeSize)
                            .clipShape(
                                Rectangle()
                                    .offset(x: -shapeSize / 2, y: -shapeSize / 2)
                            )
                            .offset(x: shapeSize / 2, y: 0)
                    }
                }
                .offset(x: 0, y: geometry.size.height - shapeSize / 2)
            }
        }
    }
}
#Preview {
    SquareDecoration(hasTopLeft: true , hasTopRight: true, hasBottomLeft: true, hasBottomRight: true)
}
