//
//  ViewController.swift
//  Quiz
//
//  Created by user on 8/28/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit
import Pastel

class ViewController: UIViewController, MyDelegate {
    
    @IBOutlet weak var questionLabel: UILabel!
    private var quiz: Quiz!
    private var secondViewController: SecondViewController!
    private var array: [Question] = [] {
        didSet {
            quiz.content = array
            self.renderQuestion()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let pastelView = PastelView(frame: view.bounds)
        
        // Custom Direction
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        
        // Custom Duration
        pastelView.animationDuration = 3.0
        
        // Custom Color
        pastelView.setColors([UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
                              UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
                              UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
                              UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)])
        
        pastelView.startAnimation()
        view.insertSubview(pastelView, at: 0)
        startQuiz()
    }
    
    func startQuiz(){
        _ = navigationController?.popViewController(animated: true)
        quiz = Quiz.instance
        AlamofireHelper.shared.getQuestions { (response) in
            self.array = response.questions
        }
//        let apihelper: APIHelper = APIHelper()
//        apihelper.makeRequest(){
//            (data) ->  Void in
//            let content = apihelper.convertToDictionary(text: data as String)?["content"]
//            print(content ?? "lol")
//            self.quiz.content = (content as? [Question])!
//        }
//        if let theJSONData = try? JSONSerialization.data(
//            withJSONObject: quiz.content,
//            options: []) {
//            let theJSONText = String(data: theJSONData,
//                                     encoding: String.Encoding.utf8)
//            print("JSON string = \(theJSONText!)")
//        }
    }
    
    func renderQuestion(){
        questionLabel.text = (quiz.content[quiz.counter].text )
        let answers: [String] = quiz.content[quiz.counter].answers
        var order: Int = 0
        for answer in answers{
            renderAnswer(answer: answer, order: order)
            order += 1
        }
    }
    
    func renderAnswer(answer: String, order: Int){
        let button = UIButton(frame: CGRect(x: 100, y: (order + 2) * 50, width: 100, height: 50))
        button.setTitle(answer, for: UIControlState.normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.tag = order
        self.view.addSubview(button)
    }
    
    func buttonTapped(sender: UIButton){
        quiz.content[quiz.counter].guessed = sender.tag
        if(sender.tag == quiz.content[quiz.counter].right){
            quiz.score += 1
        }
        quiz.counter += 1
        clearView()
        if(quiz.counter < quiz.content.count){
            renderQuestion()
        }
        else if(quiz.counter >= quiz.content.count){
            secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "second") as! SecondViewController
            secondViewController.delegate = self
            secondViewController.quiz = quiz
            navigationController?.pushViewController(secondViewController, animated: true)
        }
    }
    
    func clearView(){
        for view in self.view.subviews{
            if(view is UIButton){
                view.removeFromSuperview()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
