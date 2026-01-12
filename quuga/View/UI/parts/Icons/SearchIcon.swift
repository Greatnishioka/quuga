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
        path.move(to: CGPoint(x: 0.95348*width, y: 0.98096*height))
        path.addLine(to: CGPoint(x: 0.7374*width, y: 0.75407*height))
        path.addLine(to: CGPoint(x: 0.7649*width, y: 0.72785*height))
        path.addLine(to: CGPoint(x: 0.98097*width, y: 0.95474*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.41104*width, y: 0.84166*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.41104*width, y: 0.01896*height))
        path.closeSubpath()
        return path
    }
}
