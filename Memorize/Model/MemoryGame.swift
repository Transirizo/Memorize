//
//  MemoryGame.swift
//  Memorize
//
//  Created by 陈汉超 on 2021/8/14.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var Cards: [Card]
    private(set) var Score = 0
    private(set) var ThemeName: String
    
    init(numberOfPairsOfCards: Int, themeName: String, creatCardContent: (Int) -> CardContent) {
        // Swift know the Cards is Array<Card>
        Cards = []
        // add numberOfPairdsOfCard x2 cards to Cards Array
        // let the id equal pairIndex mutiply 2(+1), make them identifiable
        for pairIndex in 0 ..< numberOfPairsOfCards {
            let content = creatCardContent(pairIndex)
            Cards.append(Card(content: content, id: pairIndex*2))
            Cards.append(Card(content: content, id: pairIndex*2 + 1))
            Cards.shuffle()
        }
        ThemeName = themeName
    }
    
    private var indexOfTheOnlyFaceUpCard: Int? {
        get { Cards.indices.filter { Cards[$0].isFaceUp && !Cards[$0].isMatch }.oneAndOnly }
        //      let  faceUpCardsIndeices = Cards.indices.filter { Cards[$0].isFaceUp  &&  !Cards[$0].isMatch }
        //      if faceUpCardsIndeices.count == 1 {
        //        return faceUpCardsIndeices.first
        //      } else {
        //        return nil
        //      }
        set { Cards.indices.forEach { Cards[$0].isFaceUp = !($0 != newValue && !Cards[$0].isMatch) }}
        //      for  index in Cards.indices  {
        //        Cards[index].isFaceUp = !(index != newValue && !Cards[index].isMatch)
        //        if index != newValue  &&  !Cards[index].isMatch  {
        //          Cards[index].isFaceUp  =  false
        //        }  else  {
        //          Cards[index].isFaceUp  =  true
        //        }
        //      }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = Cards.firstIndex(where: { $0.id == card.id }), !Cards[chosenIndex].isFaceUp, !Cards[chosenIndex].isMatch {
            if let potentialMacthCardIndex = indexOfTheOnlyFaceUpCard {
                if Cards[chosenIndex].content == Cards[potentialMacthCardIndex].content {
                    Cards[potentialMacthCardIndex].isMatch = true
                    Cards[chosenIndex].isMatch = true
                    Score += 2
                } else {
                    if Cards[chosenIndex].isHaveBeenSeen && Cards[potentialMacthCardIndex].isHaveBeenSeen {
                        Score -= 2
                    } else if (Cards[potentialMacthCardIndex].isHaveBeenSeen && !Cards[chosenIndex].isHaveBeenSeen) || (!Cards[potentialMacthCardIndex].isHaveBeenSeen && Cards[chosenIndex].isHaveBeenSeen) {
                        Score -= 1
                    }
                    if !Cards[chosenIndex].isHaveBeenSeen {
                        Cards[chosenIndex].isHaveBeenSeen = true
                    }
                    if !Cards[potentialMacthCardIndex].isHaveBeenSeen {
                        Cards[potentialMacthCardIndex].isHaveBeenSeen = true
                    }
                }
            } else {
                indexOfTheOnlyFaceUpCard = chosenIndex
            }
            Cards[chosenIndex].isFaceUp = true
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        
        var isMatch = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        
        let content: CardContent
        var isHaveBeenSeen = false
        let id: Int
        
        // MARK: - Bonus Times

        var bonusTimeLimit: TimeInterval = 20
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        var hasEarnBonus: Bool {
            isMatch && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatch && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
    }
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
