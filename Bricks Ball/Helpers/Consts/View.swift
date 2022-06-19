//
//  View.swift
//  Bricks Ball
//
//  Created by peo on 2022/06/18.
//

import UIKit

extension Const {
    struct View {
        struct TopToolBar {
            static let width = UIScreen.main.bounds.width
            static let height = UIScreen.main.bounds.height * 0.2
            static let size = CGSize(width: width, height: height)
            
            struct CurrentScoreLabel {
                static let fontSize = 40.0
            }
            
            struct TopScoreLabel {
                static let fontSize = 16.0
            }
            
            struct SettingButton {
                static let width = 32.0
                static let height = 32.0
                static let size = CGSize(width: width, height: height)
            }
        }
        
        struct BottomToolBar {
            static let width = UIScreen.main.bounds.width
            static let height = UIScreen.main.bounds.height * 0.1
            static let size = CGSize(width: width, height: height)
        }
    }
}

