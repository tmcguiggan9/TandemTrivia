//
//  ViewController.swift
//  TandemTrivia
//
//  Created by Edward McGuiggan on 10/31/20.
//  Copyright © 2020 Edward McGuiggan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var optionAButton: UIButton!
    @IBOutlet weak var optionBButton: UIButton!
    @IBOutlet weak var optionCButton: UIButton!
    @IBOutlet weak var optionDButton: UIButton!
    @IBOutlet weak var playAgain: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        playAgain.isHidden = true
    }
    
    var questionNumber = 0
    var score = 0
    var correct: String!
    
    @objc func fetchData() {
        
        if questionNumber == 10 {
            scoreLbl.text = "Game Over. You scored \(score) out of 10"
            optionAButton.isEnabled = false
            optionBButton.isEnabled = false
            optionCButton.isEnabled = false
            optionDButton.isEnabled = false
            playAgain.isHidden = false
            
        } else{
            
            guard let path = Bundle.main.path(forResource: "Apprentice_TandemFor400_Data", ofType: "json") else {return}
            
            let url = URL(fileURLWithPath: path)
            
            do {
                let data = try Data(contentsOf: url)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                
                guard let array = json as? [Any] else {return}
                
                let array2 = array.shuffled()
                
                let item = array2[questionNumber]
                guard let triviaDict = item as? [String: Any] else {return}
                guard let question = triviaDict["question"] as? String else {return}
                guard var incorrect = triviaDict["incorrect"] as? [String?] else {return}
                correct = triviaDict["correct"] as? String
                
                
                incorrect.append(correct)
                incorrect.shuffle()
                
                
                
                let questionA = incorrect[0]
                let questionB = incorrect[1]
                let questionC = incorrect[2]
                
                if incorrect.count == 3 {
                    optionDButton.setTitle("", for: .normal)
                } else {
                    let questionD = incorrect[3]
                    optionDButton.setTitle(questionD!, for: .normal)
                }
                
                questionLbl.text = question
                optionAButton.setTitle(questionA!, for: .normal)
                optionBButton.setTitle(questionB!, for: .normal)
                optionCButton.setTitle(questionC!, for: .normal)
                
                
                
                
                questionNumber = questionNumber + 1
                
                
                
            } catch {
                print(error)
            }
            
            optionAButton.backgroundColor = #colorLiteral(red: 0.5882352941, green: 0.737254902, blue: 0.737254902, alpha: 1)
            optionBButton.backgroundColor = #colorLiteral(red: 0.5882352941, green: 0.737254902, blue: 0.737254902, alpha: 1)
            optionCButton.backgroundColor = #colorLiteral(red: 0.5882352941, green: 0.737254902, blue: 0.737254902, alpha: 1)
            optionDButton.backgroundColor = #colorLiteral(red: 0.5882352941, green: 0.737254902, blue: 0.737254902, alpha: 1)
            
        }
        
    }
    
    
    
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        if sender.currentTitle == correct{
            sender.backgroundColor = UIColor.green
            score += 1
            scoreLbl.text = "Score: \(score)/\(questionNumber)"
            
        } else if optionAButton.currentTitle == correct{
            sender.backgroundColor = UIColor.red
            optionAButton.backgroundColor = UIColor.green
            scoreLbl.text = "Score: \(score)/\(questionNumber)"
            // optionAButton.backgroundColor = UIColor.green
        } else if optionBButton.currentTitle == correct {
            sender.backgroundColor = UIColor.red
            optionBButton.backgroundColor = UIColor.green
            scoreLbl.text = "Score: \(score)/\(questionNumber)"
        } else if optionCButton.currentTitle == correct {
            sender.backgroundColor = UIColor.red
            optionCButton.backgroundColor = UIColor.green
            scoreLbl.text = "Score: \(score)/\(questionNumber)"
        } else if optionDButton.currentTitle == correct {
            sender.backgroundColor = UIColor.red
            optionDButton.backgroundColor = UIColor.green
            scoreLbl.text = "Score: \(score)/\(questionNumber)"
        }
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fetchData), userInfo: nil, repeats: false)
    }
    
    
    
    
    
    @IBAction func playAgainBtn(_ sender: UIButton) {
        questionNumber = 0
        score = 0
        scoreLbl.text = "Score: 0/0"
        playAgain.backgroundColor = #colorLiteral(red: 0.5882352941, green: 0.737254902, blue: 0.737254902, alpha: 1)
        playAgain.isHidden = true
        optionAButton.isEnabled = true
        optionBButton.isEnabled = true
        optionCButton.isEnabled = true
        optionDButton.isEnabled = true
        
        
    }
    
    
}

