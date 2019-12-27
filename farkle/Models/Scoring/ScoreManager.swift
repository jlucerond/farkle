//
//  ScoreManager.swift
//  farkle
//
//  Created by Joe Lucero on 12/22/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import Foundation

struct ScoreManager {
    /// this gives a dictionary where key is 1 thorugh 6 and value is how many of each we have.
    typealias DiceDictionary = [Int: Int]

    func getAllPossibleScoresFrom(dice: [Dice]) -> [Score] {
        var scores = [Score]()
        let diceDictionary = putIntoDictionary(dice: dice)

        if dice.count == 6 {
            // These would account for all the scenarios where you use up every dice in a roll
            if hasTwoTriples(diceDictionary: diceDictionary) {
                scores.append(Score(kind: .twoTriples))
            } else if hasThreePairs(diceDictionary: diceDictionary) {
                scores.append(Score(kind: .threePairs))
            } else if hasSixStraight(diceDictionary: diceDictionary) {
                scores.append(Score(kind: .sixStraight))
            } else if hasSixOfAKind(diceDictionary: diceDictionary) {
                scores.append(Score(kind: .sixOfAKind))
            } else if hasFourOfAKindPlusPair(diceDictionary: diceDictionary) {
                scores.append(Score(kind: .fourOfAKindPlusPair))
            }
        }

        // If we have one of these, we hit the jackpot and don't need to check anything else.
        if !scores.isEmpty { return scores }

        // Now we need to check for all other possibilities watching for overlap
        if let diceValue = hasFiveOfAKind(diceDictionary: diceDictionary) {
            scores.append(Score(kind: .fiveOfAKind(diceValue: diceValue)))
        } else if let diceValue = hasFourOfAKind(diceDictionary: diceDictionary) {
            scores.append(Score(kind: .fourOfAKind(diceValue: diceValue)))
        } else if let diceValue = hasThreeOfAKind(diceDictionary: diceDictionary) {
            scores.append(Score(kind: .threeOfAKind(diceValue: diceValue)))
        }

        // Then see if we have leftover (wasn't used above) fives or ones
        let numberOfFives = remainingFives(diceDictionary: diceDictionary)
        for _ in 0..<numberOfFives {
            scores.append(Score(kind: .five))
        }

        let numberOfOnes = remainingOnes(diceDictionary: diceDictionary)
        for _ in 0..<numberOfOnes {
            scores.append(Score(kind: .one))
        }

        return scores
    }

    /// This method does not guarantee reference semantics
    func getDiceNeedFor(scores: [Score], from allDice: [Dice]) -> [Dice] {
        var diceUsed = [Dice]()
        for score in scores {
            switch score.kind {
            case .twoTriples, .threePairs, .sixStraight, .sixOfAKind, .fourOfAKindPlusPair:
                guard allDice.count == 6 else {
                    assertionFailure("Dice and scores don't match")
                    return []
                }
                return allDice
            case .fiveOfAKind(diceValue: let value):
                diceUsed.append(contentsOf: allDice.filter {$0.value == value})
            case .fourOfAKind(diceValue: let value):
                diceUsed.append(contentsOf: allDice.filter {$0.value == value})
            case .threeOfAKind(diceValue: let value):
                diceUsed.append(contentsOf: allDice.filter {$0.value == value})
            case .five:
                diceUsed.append(Dice(value: 5))
            case .one:
                diceUsed.append(Dice(value: 1))
            }
        }
        return diceUsed
    }
}

private extension ScoreManager {
    func putIntoDictionary(dice: [Dice]) -> DiceDictionary {
        var diceDictionary = [Int: Int]()
        for singleDice in dice {
            let valueOnDice = singleDice.value
            guard valueOnDice <= 6, valueOnDice > 0 else {
                assertionFailure("Your dice's value is wrong")
                continue
            }

            if let numberOfDiceAlreadyCounted = diceDictionary[valueOnDice] {
                diceDictionary[valueOnDice] = numberOfDiceAlreadyCounted + 1
            } else {
                diceDictionary[valueOnDice] = 1
            }
        }
        return diceDictionary
    }

    private func hasTwoTriples(diceDictionary: DiceDictionary) -> Bool {
        guard diceDictionary.keys.count == 2 else { return false }

        for (_, value) in diceDictionary {
            if value != 3 {
                return false
            }
        }
        return true
    }

    private func hasThreePairs(diceDictionary: DiceDictionary) -> Bool {
        guard diceDictionary.keys.count == 3 else { return false }

        for (_, value) in diceDictionary {
            if value != 2 {
                return false
            }
        }
        return true
    }

    private func hasSixStraight(diceDictionary: DiceDictionary) -> Bool {
        return diceDictionary.keys.count == 6 ? true : false
    }

    private func hasSixOfAKind(diceDictionary: DiceDictionary) -> Bool {
        return diceDictionary.keys.count == 1 ? true : false
    }

    private func hasFourOfAKindPlusPair(diceDictionary: DiceDictionary) -> Bool {
        guard diceDictionary.keys.count == 2 else { return false }

        for (_, value) in diceDictionary {
            if value != 2 && value != 4 {
                return false
            }
        }
        return true
    }

    private func hasFiveOfAKind(diceDictionary: DiceDictionary) -> Int? {
        for (diceValue, numberOfDice) in diceDictionary {
            if numberOfDice == 5 { return diceValue }
        }
        return nil
    }

    private func hasFourOfAKind(diceDictionary: DiceDictionary) -> Int? {
        for (diceValue, numberOfDice) in diceDictionary {
            if numberOfDice == 4 { return diceValue }
        }
        return nil
    }

    private func hasThreeOfAKind(diceDictionary: DiceDictionary) -> Int? {
        for (diceValue, numberOfDice) in diceDictionary {
            if numberOfDice == 3 { return diceValue }
        }
        return nil
    }

    private func remainingFives(diceDictionary: DiceDictionary) -> Int {
        guard let numberOfFives = diceDictionary[5] else { return 0 }
        return numberOfFives >= 3 ? 0 : numberOfFives
    }

    private func remainingOnes(diceDictionary: DiceDictionary) -> Int {
        guard let numberOfOnes = diceDictionary[1] else { return 0 }
        return numberOfOnes >= 3 ? 0 : numberOfOnes
    }

}
