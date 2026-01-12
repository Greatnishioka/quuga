//
//  Config.swift
//  quuga
//
//  Created by 西岡 on 2026/01/12.
//

import Foundation

public enum AppConfig {
    public enum API {
        public static let baseURL = "https://api.example.com" // 仮置き
        public static let timeout: TimeInterval = 30.0
    }
    
    public enum UI {
        public static let padding: CGFloat = 16.0
        
        public enum border {
            public static let thin: CGFloat = 0.5
            public static let normal: CGFloat = 1.0
        }
    }
}
