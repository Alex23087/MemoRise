//
//  QuestionViewController.swift
//  MemoRise
//
//  Created by Raffaele Scala on 17/10/18.
//  Copyright © 2018 BeesOnMars. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController{
    var Qindex : Int = -1;
    var NumberOfPages: Int = -1;
    var questionObj: Question?;
    var delegate : GameDelegate?
    
    @IBOutlet var question: UILabel!
    @IBOutlet var answers: [UIButton]!
    @IBOutlet var pageControl: UIPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuestion(inQuestion: questionObj!);
        self.pageControl.numberOfPages = self.NumberOfPages
        self.pageControl.currentPage = self.Qindex
        
    }
    override func viewDidAppear(_ animated: Bool) {
        switch self.Qindex {
        case  0:
                backButton.backgroundColor = UIColor.darkGray
        case delegate!.questionNum-1:
                nextButton.backgroundColor = UIColor.darkGray
        default:
            break
        }
    }
    
    func loadQuestion(inQuestion: Question) {
        self.question.text = inQuestion.question
        for i in 0..<inQuestion.answers.count{
            self.answers[i].isHidden = false
            self.answers[i].setTitle(inQuestion.answers[i], for: .normal)
        }
    }
    @IBOutlet var nextButton: UIButton!
    @IBAction func goNext(_ sender: Any) {
        if(self.Qindex != delegate!.questionNum-1){
            delegate?.move(index: Qindex+1, direction: .forward);
        }
    }
    @IBOutlet var backButton: UIButton!
    @IBAction func goBack(_ sender: Any) {
        if(self.Qindex != 0){
            delegate?.move(index: Qindex-1, direction: .reverse);
        }
    }
    
}
