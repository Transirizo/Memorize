//
//  Theme.swift
//  Memorize
//
//  Created by 陈汉超 on 2021/8/16.
//

import Foundation

struct Theme {
    private(set) var ThemeName: String
    private(set) var ThemeContent: [String]
    
    enum themeNmae {
        static let Human = ["👮‍♀️", "👩‍🏭", "👨‍🏫", "👨‍💼", "🧑‍🏫", "👩‍💼", "👨‍💻", "👨‍🔬", "🧑‍🔬", "👨‍🎓", "👩‍🎓", "🧑‍🌾", "👩‍🌾"]
        static let Animal = ["😾", "🐯", "🐱", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐔"]
        static let Building = ["🏨", "🏪", "🏫", "🏩", "💒", "🏥", "⛪️", "🏤", "🏘", "🏭", "🏢", "🏬", "🏣", "🏠", "🛖", "⛩"]
        static let Fruit = ["🍏", "🍎", "🍐", "🍋", "🍊", "🍌", "🍉", "🍇", "🥝", "🍈", "🍒", "🍑", "🍍"]
        static let Vehicles = ["🚗", "🚕", "🚌", "🚙", "🏎", "🚑", "🚓", "🚛", "🚐", "🚒", "🛻"]
        static let Face = ["😷", "🤐", "😵‍💫", "😼", "😒", "🙁", "😘", "🙃", "😍", "🤧", "🤠"]
    }
    
    init(_ themeName: String, creatTheme: (String) -> [String]) {
        ThemeName = themeName
        ThemeContent = creatTheme(ThemeName)
    }
    
    //    func SelectTheme(_ ThemeName: String) -> [String]{
    //        switch ThemeName {
    //        case "Human":
    //            return ["👮‍♀️","👩‍🏭","👨‍🏫","👨‍💼","🧑‍🏫","👩‍💼","👨‍💻","👨‍🔬","🧑‍🔬","👨‍🎓","👩‍🎓","🧑‍🌾","👩‍🌾"]
    //        case "Animal":
    //            return ["😾","🐯","🐱","🐹","🐰","🦊","🐻","🐼","🐻‍❄️","🐔"]
    //        case "Building":
    //            return ["🏨","🏪","🏫","🏩","💒","🏥","⛪️","🏤","🏘","🏭","🏢","🏬","🏣","🏠","🛖","⛩"]
    //        case "Fruit":
    //            return ["🍏","🍎","🍐","🍋","🍊","🍌","🍉","🍇","🥝","🍈","🍒","🍑","🍍"]
    //        case "Vehicles":
    //            return ["🚗","🚕","🚌","🚙","🏎","🚑","🚓","🚛","🚐","🚒","🛻"]
    //        case "Face":
    //            return ["😷","🤐","😵‍💫","😼","😒","🙁","😘","🙃","😍","🤧","🤠"]
    //        default:
    //            return [ThemeName]
    //        }
    //    }
}
