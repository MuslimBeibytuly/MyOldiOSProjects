//
//  Question.swift
//  Quiz
//
//  Created by user on 05.10.17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class Question: NSObject {
    var text: String
    var answers: [String]
    var right: Int
    var guessed: Int
    init(text: String, answers: [String], right: Int, guessed: Int) {
        self.text = text
        self.answers = answers
        self.right = right
        self.guessed = guessed
    }
    init?(with json: JSON) {
        guard let text = json["text"] as? String,
            let answers = json["answers"] as? [String],
            let right = json["right"] as? Int,
            let guessed = json["guessed"] as? Int
            else {
                return nil
        }
        self.text = text
        self.answers = answers
        self.right = right
        self.guessed = guessed
    }
}
