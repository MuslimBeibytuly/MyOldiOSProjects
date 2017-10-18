//
//  MyTableViewCell.swift
//  Quiz
//
//  Created by user on 9/26/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    var question: UILabel!
    var answer: UILabel!
    var guessed: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let width = frame.width
        let height = frame.height
        
        question = UILabel(frame: CGRect(x: 10, y: 20, width: width / 2, height: 20))
        question.textColor = UIColor.white
        answer = UILabel(frame: CGRect(x: width / 2 + 10, y: 20, width: 200, height: 20))
        answer.textColor = UIColor.white
        guessed = UILabel(frame: CGRect(x: width / 2 + 10, y: height / 2 + 20, width: 200, height: 20))
        guessed.textColor = UIColor.white
        
        self.addSubview(question)
        self.addSubview(answer)
        self.addSubview(guessed)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
