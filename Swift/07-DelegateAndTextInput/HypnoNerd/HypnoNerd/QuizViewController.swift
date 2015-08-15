//
//  QuizViewController.swift
//  Quiz
//
//  Created by luckytantanfu on 8/1/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    var currentQuestionIndex = 0
    
    var questions = [String]()
    var answers = [String]()
    
    @IBOutlet weak var questionLabel: UILabel?
    @IBOutlet weak var answerLabel: UILabel?
    
    @IBAction func showQuestion(sender: AnyObject) {
        ++currentQuestionIndex
        
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        
        let question = questions[currentQuestionIndex]
        questionLabel?.text = question
        
        answerLabel?.text = "???"
    }

    @IBAction func showAnswer(sender: AnyObject) {
        let answer = answers[currentQuestionIndex]
        answerLabel!.text = answer
    }
    
    override func loadView() {
        NSBundle.mainBundle().loadNibNamed("QuizViewController", owner: self, options: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        questions = [
            "From what is cognac made?",
            "What is 7+7?",
            "What is the capital of Vermont?"
        ]
        
        answers = [
            "Grapes",
            "14",
            "Montpelier"
        ]

        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    

}
