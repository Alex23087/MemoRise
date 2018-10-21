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
        gameCollection.ind = Qindex;
//        self.pageControl.numberOfPages = self.NumberOfPages
//        self.pageControl.currentPage = self.Qindex
//
    }
    override func viewDidAppear(_ animated: Bool) {
        switch self.Qindex {
        case  0:
                backButton.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        case delegate!.questionNum-1:
                nextButton.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
                nextButton.setTitle("Finish", for: .normal)
        default:
            break
        }
        for btn in answers {
            btn.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            btn.layer.masksToBounds = true;
            btn.layer.cornerRadius = 15;
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
                answers[i].backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            } else {
                answers[i].backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            }
        }
        delegate!.setAnswer(index: Qindex, result: pressed==questionObj!.correctAnswer)
    }
    
    @IBAction func onHome(_ sender: Any) {
        navigationController?.popViewController(animated: true);
    }
}
