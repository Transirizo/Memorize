//
//  Cardify.swift
//  Memorize
//
//  Created by 陈汉超 on 2021/9/15.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    var color: Color
    var isMatch: Bool
    var rotation: Double
    
    var animatableData: Double {
        set{ rotation = newValue }
        get{ rotation }
    }
    
    init(Color: Color, isFaceUp: Bool, IsMatch: Bool) {
        rotation = isFaceUp ? 0 : 180
        color = Color
        isMatch = IsMatch
    }
    
    func body(content: Content) -> some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation  < 90  {
                shape.fill().foregroundColor(color)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                if isMatch{
                    shape.fill().foregroundColor(color)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth).foregroundColor(DrawingConstants.matchColor)
                }
            }  else  {
                shape.fill()
            }
            content.opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle(degrees: rotation), axis: (0, 1, 0))
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 17
        static let lineWidth: CGFloat = 3
        static let matchColor: Color = .blue
    }
}

extension View {
    func cardify(color: Color, isFaceUp: Bool, isMatch: Bool) -> some View{
        self.modifier(Cardify(Color: color, isFaceUp: isFaceUp, IsMatch: isMatch))
    }
}
