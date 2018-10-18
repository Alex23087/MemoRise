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
//    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var gameCollection: GameCollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuestion(inQuestion: questionObj!);
        gameCollection.dataSource = gameCollection;
        gameCollection.gameDelegate = delegate;
//        self.pageControl.numberOfPages = self.NumberOfPages
//        self.pageControl.currentPage = self.Qindex
//
    }
    override func viewDidAppear(_ animated: Bool) {
        switch self.Qindex {
        case  0:
                backButton.backgroundColor = UIColor.darkGray
        case delegate!.questionNum-1:
                nextButton.backgroundColor = UIColor.darkGray
                nextButton.setTitle("Finish", for: .normal)
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
            delegate?.move(index: Qindex+1);
        } else {
            self.navigationController?.popViewController(animated: true);
            let resultsController = storyboard!.instantiateViewController(withIdentifier: "results") as! ResultsViewController;
            resultsController.res = String(delegate!.getScore())+"/"+String(delegate!.questionNum);
            self.navigationController?.pushViewController(resultsController, animated: false);
        }
    }
    @IBOutlet var backButton: UIButton!
    @IBAction func goBack(_ sender: Any) {
        if(self.Qindex != 0){
            delegate?.move(index: Qindex-1);
        }
    }
    @IBAction func answer1(_ sender: Any) {
        pressButton(pressed: 0)
    }
    @IBAction func answer2(_ sender: Any) {
        pressButton(pressed: 1)
    }
    @IBAction func answer3(_ sender: Any) {
        pressButton(pressed: 2)
    }
    @IBAction func answer4(_ sender: Any) {
        pressButton(pressed: 3)
    }
    func pressButton(pressed : Int){
        for i in 0..<4{
            if i == pressed {
                answers[i].backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
            } else {
                answers[i].backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            }
        }
        delegate!.setAnswer(index: Qindex, result: pressed==questionObj!.correctAnswer)
    }
    
}
