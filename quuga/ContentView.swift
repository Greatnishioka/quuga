//
//  ContentView.swift
//  quuga
//
//  Created by 西岡 on 2026/01/08.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            Navigator()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}
