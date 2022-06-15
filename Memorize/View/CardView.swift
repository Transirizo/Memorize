//
//  CardView.swift
//  Memorize
//
//  Created by 陈汉超 on 2021/8/17.
//

import SwiftUI

struct CardView: View {
    
    @State var animateBonusTimeRemaining: Double = 0
    
    private let card: EmojiMemoryGame.Card

    init(_ Card: EmojiMemoryGame.Card) {
        card  =  Card
    }
    
    let color = EmojiMemoryGame().ModeColor
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 17
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.65
        static let matchColor: Color  = .accentColor
        static let fontSize: CGFloat = 32
    }
    
    private func font (in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.height, size.width) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Group{
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: (1 - animateBonusTimeRemaining) * 360 - 90))
                            .onAppear {
                                animateBonusTimeRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animateBonusTimeRemaining = 0
                                }
                            }
                    } else if !card.isHaveBeenSeen {
                        Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: 0.01 - 90))
                    } else {
                        Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: (1 - card.bonusRemaining) * 360 - 90))
                    }
                }
                .padding(5)
                .opacity(0.5)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatch ? 360 : 0))
                    .animation(
                        card.isMatch
                            ? .linear(duration: 2).repeatForever(autoreverses: false)
                        : .none)
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(color: color, isFaceUp: card.isFaceUp, isMatch: card.isMatch)
        }
    }
}
