//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by 陈汉超 on 2021/8/14.
//

import SwiftUI

class EmojiMemoryGame:  ObservableObject {
  
    typealias Card = MemoryGame<String>.Card
  
  private static func creatTheme()  ->  Theme {
    let AllTheme  =  ["Fruit","Building","Animal","Face","Vehicles","Human"]
    let Name  =  AllTheme[Int.random(in: 0..<AllTheme.count)]
    //创建主题，利用主题初始化函数初始化
    return Theme(Name){ Name in
      switch Name {
      case "Human":
        return Theme.themeNmae.Human
      case "Animal":
        return Theme.themeNmae.Animal
      case "Building":
        return Theme.themeNmae.Building
      case "Fruit":
        return Theme.themeNmae.Fruit
      case "Vehicles":
        return Theme.themeNmae.Vehicles
      case "Face":
        return Theme.themeNmae.Face
      default:
        return [Name]
      }
    }
  }
  
  private static func creatMemoryGame () -> MemoryGame<String> {
    let theme = creatTheme()
    let emojisCount = theme.ThemeContent.count
    return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 3..<emojisCount), themeName: theme.ThemeName) { pairIndex in
      theme.ThemeContent[pairIndex]
    }
  }
  
    @Published private var model  =  creatMemoryGame()
  
  
  var cards: Array<Card> {
      model.Cards
  }
  
  var score: Int {
    model.Score
  }
  //MARK: Intents
  
  func choose(_ card: Card){
    model.choose(card)
  }
  
  func newgame() {
    model = EmojiMemoryGame.creatMemoryGame()
  }
  
  var theme: String{
    model.ThemeName
  }
  
  
  var color: Color {
    switch model.ThemeName {
    case "Human":
      return .orange
    case "Animal":
      return .pink
    case "Building":
      return .gray
    case "Fruit":
      return .purple
    case "Vehicles":
      return .green
    case "Face":
      return .yellow
    default:
      return .clear
    }
  }
  
  var ModeColor: Color {
    let currentMode = UITraitCollection.current.userInterfaceStyle
    if currentMode == .dark {
      return .black.opacity(0.4)
    }else{
      return .white
    }
  }
}
