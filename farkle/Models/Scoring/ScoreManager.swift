//
//  ScoreManager.swift
//  farkle
//
//  Created by Joe Lucero on 12/22/19.
//  Copyright © 2019 Joe Lucero. All rights reserved.
//

import Foundation

struct ScoreManager {
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
        if hasFiveOfAKind(diceDictionary: diceDictionary) {
            scores.append(Score(kind: .fiveOfAKind))
        } else if hasFourOfAKindPlusPair(diceDictionary: diceDictionary) {
            scores.append(Score(kind: .fourOfAKind))
        } else if hasThreeOfAKind(diceDictionary: diceDictionary) {
            if let value = diceDictionary.first(where: { $1 == 3 }) {
                scores.append(Score(kind: .threeOfAKind(diceValue: value.key)))
            } else {
                assertionFailure("Something went wrong here")
            }
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
}

private extension ScoreManager {
    /// this gives a dictionary where key is 1 thorugh 6 and value is how many of each we have.
    typealias DiceDictionary = [Int: Int]
    func putIntoDictionary(dice: [Dice]) -> DiceDictionary {
        var diceDictionary = [Int: Int]()
        for singleDice in dice {
            let valueOnDice = singleDice.value
            guard valueOnDice <= 6, valueOnDice > 0 else { assertionFailure("Your dice's value is wrong"); continue }

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

    private func hasFiveOfAKind(diceDictionary: DiceDictionary) -> Bool {
        for (_, value) in diceDictionary {
            if value == 5 { return true }
        }
        return false
    }

    private func hasFourOfAKind(diceDictionary: DiceDictionary) -> Bool {
        for (_, value) in diceDictionary {
            if value == 4 { return true }
        }
        return false
    }

    private func hasThreeOfAKind(diceDictionary: DiceDictionary) -> Bool {
        for (_, value) in diceDictionary {
            if value == 3 { return true }
        }
        return false
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
