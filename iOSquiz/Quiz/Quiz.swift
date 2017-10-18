//
//  Quiz.swift
//  Quiz
//
//  Created by user on 8/28/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class Quiz: NSObject {
    var content: [Question]
    var counter: Int
    var score: Int
    static let instance: Quiz = {
        return Quiz()
    }()
    private override init() {
        content = [Question(text: "2+2?", answers: ["1","2","3","4"], right: 3, guessed: -1), Question(text: "2+7?", answers: ["1", "2", "9"], right: 2, guessed: -1),
                   Question(text: "2+3?", answers: ["1", "2", "5"], right: 2, guessed: -1),Question(text: "2+8?", answers: ["10", "2", "5"], right: 0, guessed: -1),
                   Question(text: "2+4?", answers: ["6", "2", "5"], right: 0, guessed: -1), Question(text: "2+9?", answers: ["1", "11", "5"], right: 1, guessed: -1),
                   Question(text: "2+5?", answers: ["1","2","7","4"], right: 2, guessed: -1), Question(text: "2+10?", answers: ["1", "12", "5"], right: 1, guessed: -1),
                   Question(text: "2+6?", answers: ["1", "8", "5"], right: 1, guessed: -1),Question(text: "2+11?", answers: ["1", "2", "13"], right: 2, guessed: -1),
        ]
        content = content.shuffled()
        content = Array(content[0..<5])
        counter = 0
        score = 0
    }
}

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

