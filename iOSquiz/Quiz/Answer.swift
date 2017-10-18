//
//  Answer.swift
//  Quiz
//
//  Created by user on 8/28/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class Answer: NSObject {
    var text: String!
    var isRight: Bool!
    
    init(text: String, isRight: Bool) {
        self.text = text
        self.isRight = isRight
    }
}
