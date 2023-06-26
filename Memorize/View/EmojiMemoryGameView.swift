//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by 陈汉超 on 2021/8/12.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    @Namespace private var dealNamespace
    @State private var dealt = Set<Int>()
    
    private enum DrawingConstants {
        static let defalutColor: Color = .blue
    }
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }

    private func dealingAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (CardConstants.totalDuration / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }

    private func zIndex(of card: EmojiMemoryGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    @ViewBuilder
    private func dealCard(_ card: EmojiMemoryGame.Card) -> some View {
        if isUndealt(card) {
            Color.clear
        } else {
            cardView(for: card)
        }
    }
    
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        CardView(card)
            .matchedGeometryEffect(id: card.id, in: dealNamespace)
            .padding(4)
            .transition(.asymmetric(insertion: .identity, removal: .scale))
            .zIndex(zIndex(of: card))
            .onTapGesture {
                withAnimation {
                    game.choose(card)
                }
            }
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealNamespace)
                    .transition(.asymmetric(insertion: .opacity, removal: .identity))
            }
        }
        .frame(width: CardConstants.undealWidth, height: CardConstants.undealHeight)
        .foregroundColor(game.color)
        .onTapGesture {
            for card in game.cards {
                withAnimation(dealingAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    private enum CardConstants {
        static let aspectRatio: CGFloat = 2 / 3
        static let dealDuration: Double = 0.5
        static let totalDuration: Double = 2
        static let undealHeight: CGFloat = 90
        static let undealWidth = undealHeight * aspectRatio
    }
    
    var gameBody: some View {
        //      ScrollView{
        //        LazyVGrid(columns: [GridItem(.adaptive(minimum: 70, maximum: 200))]) {
        //          ForEach(game.cards) {  card in
        AspectVGrid(items: game.cards, aspectRatio: 2 / 3) { card in
            dealCard(card)
        }
        //          }
        //        }
        //      }
        .foregroundColor(game.color)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Text("Theme: \(game.theme)")
                    .font(.largeTitle)
                    .foregroundColor(game.color)
                Text("Score: \(game.score)")
                    .animation(.none)
                    .font(.title)
                    .foregroundColor(DrawingConstants.defalutColor)
                gameBody
                Spacer()
                HStack(alignment: .center) {
                    Spacer()
                    Newgame
                    //                VehiclesTheme
                    //                FaceTheme
                    //                AnimalsTheme
                }
                .font(.largeTitle)
                .foregroundColor(game.color)
                .padding(.horizontal)
            }
            .padding(.horizontal)
            deckBody
        }
    }
    
    var Newgame: some View {
        Button {
            withAnimation {
                game.newgame()
                dealt = []
            }
        } label: {
            VStack {
                Image(systemName: "gamecontroller")
                    .padding(.horizontal)
                Text("NewGame")
                    .font(.caption)
            }
        }
    }
    //    var VehiclesTheme: some View {
    //        Button {
    //            game.SelectTheme()
    //        } label: {
    //            VStack{
    //                Image(systemName: "car")
    //                    .padding(.horizontal)
    //                Text("Vehicle")
    //                    .font(.caption)
    //            }
    //        }
    //    }
    //
    //    var FaceTheme: some View {
    //        Button {
    //
    //        } label: {
    //            VStack{
    //                Image(systemName: "face.smiling")
    //                    .padding(.horizontal)
    //                Text("Face")
    //                    .font(.caption)
    //            }
    //        }
    //    }
    //
    //    var AnimalsTheme: some View {
    //        Button {
    //
    //        } label: {
    //            VStack{
    //                Image(systemName: "hare")
    //                    .padding(.horizontal)
    //                Text("Animal")
    //                    .font(.caption)
    //            }
    //        }
    //    }
    
    // append some view
    //    var append: some View {
    //        Button {
    //            if emojisCount < emojis.count{
    //                emojisCount += 1
    //            }
    //        } label: {Image(systemName: "plus.diamond")}
    //    }
    //
    //
    //    //remove some view
    //    var remove: some View {
    //        Button{
    //            if emojisCount > 1 {
    //                emojisCount -= 1
    //            }
    //        } label: {Image(systemName: "minus.diamond")}
    //    }
}

// combine View to preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        return EmojiMemoryGameView(game: game)
    }
}
