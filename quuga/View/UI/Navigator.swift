//
//  navigator.swift
//  quuga
//
//  Created by 西岡 on 2026/01/08.
//

import SwiftUI

struct Navigator: View {
    var body: some View {
        GeometryReader { geometry in

            let cornerRadius = geometry.size.width * 0.04 // 角丸の丸まり具合
            let shape = RoundedRectangle(cornerRadius: cornerRadius)
            
            HStack {
                ZStack {
                    // 1. 背景色
                    shape
                        .fill(Color.white)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 4)
                    
                    // 2. Stripe
                    Stripe()
                        .clipShape(shape)
                    
                    ZStack{
                        navigatorContent(wedgetWidth: geometry.size.width * 0.80)
                    }
                    
                    // 3. 枠線（最前面）
                    shape
                        .stroke(Color("MainGreen"), lineWidth: AppConfig.UI.border.normal)
                }
                .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.horizontal, 20)
            
        }
    }
    
    @ViewBuilder
    private func navigatorContent(wedgetWidth: CGFloat) -> some View {
        ZStack{
            VStack(spacing: 0) {
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: wedgetWidth, height: 8)
                        .overlay {
                            SquareDecoration(
                                hasTopLeft: false , hasTopRight: false, hasBottomLeft: true, hasBottomRight: true
                            )
                        }
                }
                Rectangle()
                    .fill(Color.white)
                    .frame(width: wedgetWidth, height: 60)
                    .overlay {
                        VStack {
                            Rectangle()
                                .fill(Color("MainGreen"))
                                .frame(height: AppConfig.UI.border.thin)
                            Spacer()
                            Rectangle()
                                .fill(Color("MainGreen"))
                                .frame(height: AppConfig.UI.border.thin)
                        }
                        ZStack{
                            SquareDecoration()
                            HStack {
                                HomeIcon()
                                    .fill(Color.clear)
                                    .stroke(Color("MainGreen"), lineWidth: AppConfig.UI.border.normal)
                                    .frame(width: 24, height: 24)
                                
                                SearchIcon()
                                    .fill(Color.clear)
                                    .stroke(Color("MainGreen"), lineWidth: AppConfig.UI.border.normal)
                                    .frame(width: 24, height: 24)
                                
                            }
                        }
                    }
                Rectangle()
                    .fill(Color.white)
                    .frame(width: wedgetWidth, height: 8)
                    .overlay {
                        SquareDecoration(
                            hasTopLeft: true , hasTopRight: true, hasBottomLeft: false, hasBottomRight: false
                        )
                    }
            }
            
            HStack {
                Rectangle()
                    .fill(Color("MainGreen"))
                    .frame(width: AppConfig.UI.border.thin)
                Spacer()
                Rectangle()
                    .fill(Color("MainGreen"))
                    .frame(width: AppConfig.UI.border.thin)
            }
            .frame(width: wedgetWidth)
        }
    }
}

#Preview {
    Navigator()
}
