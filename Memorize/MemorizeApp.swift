//
//  MemorizeApp.swift
//  Memorize
//
//  Created by 陈汉超 on 2021/8/12.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
