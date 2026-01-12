//
//  icon.swift
//  quuga
//
//  Created by 西岡 on 2026/01/12.
//

import SwiftUI

struct HomeIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 1.36994 * width, y: 1.07193 * height))
        path.addLine(to: CGPoint(x: 1.36994 * width, y: 1.41572 * height))
        path.addLine(to: CGPoint(x: 1.0512 * width, y: 1.41572 * height))
        path.addLine(to: CGPoint(x: 1.0512 * width, y: 0.79713 * height))
        path.addLine(to: CGPoint(x: 1.52932 * width, y: 0.45334 * height))
        path.addLine(to: CGPoint(x: 2.00745 * width, y: 0.79713 * height))
        path.addLine(to: CGPoint(x: 2.00745 * width, y: 1.41556 * height))
        path.addLine(to: CGPoint(x: 1.68867 * width, y: 1.41556 * height))
        path.addLine(to: CGPoint(x: 1.68867 * width, y: 1.07178 * height))
        path.closeSubpath()
        return path
    }
}

#Preview {
    HomeIcon()
        .fill(Color.clear)
        .stroke(Color("MainGreen"), lineWidth: AppConfig.UI.border.normal)
        .frame(width: 24, height: 24)
}
