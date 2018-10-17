//
//  QuestionViewController.swift
//  MemoRise
//
//  Created by Raffaele Scala on 17/10/18.
//  Copyright © 2018 BeesOnMars. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    var Qindex : Int = -1;
    var questionObj: Question?;
    
    @IBOutlet var question: UILabel!
    @IBOutlet var answers: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuestion(inQuestion: questionObj!);
    }
    
    func loadQuestion(inQuestion: Question) {
        //Istantiating layout
        /*question = UILabel();
        answers = [];
        for i in 0..<4{
            answers.append(UIButton());
        }*/
        self.question.text = inQuestion.question
        for i in 0..<inQuestion.answers.count{
            self.answers[i].isHidden = false
            self.answers[i].setTitle(inQuestion.answers[i], for: .normal)
        }
    }
}
