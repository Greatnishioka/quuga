//
//  CenterIcon.swift
//  quuga
//
//  Created by 西岡 on 2026/01/12.
//

import SwiftUI

struct CenterIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.addRect(CGRect(x: 0, y: 0, width: 0.98314*width, height: height))
        path.addRect(CGRect(x: 0, y: 0, width: 0.89211*width, height: height))
        path.addRect(CGRect(x: 0, y: 0, width: 0.78287*width, height: height))
        return path
    }
}

#Preview {
    CenterIcon()
        .stroke(Color.blue)
}
