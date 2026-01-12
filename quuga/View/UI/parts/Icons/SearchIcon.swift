//
//  MyIcon.swift
//  quuga
//
//  Created by 西岡 on 2026/01/12.
//
import SwiftUI

struct SearchIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.75115*width, y: 0.74099*height))
        path.addLine(to: CGPoint(x: 0.96723*width, y: 0.96789*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0, y: 0.41131*height))
        path.closeSubpath()
        return path
    }
}
