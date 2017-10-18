//
//  SecondViewController.swift
//  Quiz
//
//  Created by user on 8/28/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var quiz: Quiz!
    var scoreLabel: UILabel!
    var button: UIButton!
    var delegate: MyDelegate?
    private var myTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        renderScore()
        renderRestartButton()
        renderTable()
        // Do any additional setup after loading the view.
    }

    func renderTable() {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight + 300, width: displayWidth, height: displayHeight - barHeight))
        myTableView.register(MyTableViewCell.self, forCellReuseIdentifier: "myCell")
        myTableView.dataSource = self as UITableViewDataSource
        myTableView.delegate = self as UITableViewDelegate
        self.view.addSubview(myTableView)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quiz.content.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath as IndexPath) as! MyTableViewCell
        cell.question.text = String(describing: quiz.content[indexPath.row].text)
        cell.answer.text = String(describing: quiz.content[indexPath.row].right)
        cell.guessed.text = String(describing: quiz.content[indexPath.row].guessed)
        if(quiz.content[indexPath.row].right == quiz.content[indexPath.row].guessed) {
            cell.contentView.backgroundColor = UIColor.green
        }
        else {
            cell.contentView.backgroundColor = UIColor.red
        }
        cell.sizeToFit()
        return cell
    }

    func renderScore() {
        scoreLabel = UILabel(frame: CGRect(x: 50, y: 50, width: 200, height: 50))
        scoreLabel.text = "Right: " + String(quiz.score) + ", Total: " + String(quiz.content.count)
        view.addSubview(scoreLabel)
    }

    func renderRestartButton() {
        button = UIButton(frame: CGRect(x: 100, y: 150, width: 100, height: 50))
        button.setTitle("restart", for: UIControlState.normal)
        button.backgroundColor = UIColor.green
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.view.addSubview(button)
    }

    func buttonTapped(sender: UIButton) {
        delegate?.startQuiz()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: {
            (UIViewControllerTransitionCoordinatorContext) -> Void in
            
            let orient = UIApplication.shared.statusBarOrientation
            
            switch orient {
                case .portrait:
                    print("Portrait")
                    self.applyPortraitConstraint()
                    break
                default:
                    print("LandScape")
                    self.applyLandscapeConstraint()
                    break
            }
        }, completion: {(UIViewControllerTransitionCoordinatorContext) -> Void in
            print("rotation completed")
        })
    }
    
    func applyPortraitConstraint() -> Void {
        UIView.animate(withDuration: 10, animations: {
            let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
            
            var frame = self.myTableView.frame
            frame.origin.x = 0
            frame.origin.y = barHeight + 300
            self.myTableView.frame = frame
        })
    }
    
    func applyLandscapeConstraint() -> Void {
        UIView.animate(withDuration: 10, animations: {
            let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
            
            var frame = self.myTableView.frame
            frame.origin.x = self.view.frame.width / 2
            frame.origin.y = barHeight + 30
            self.myTableView.frame = frame
        })
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
