//
//  GameViewController.swift
//  MemoRise
//
//  Created by Raffaele Scala on 17/10/18.
//  Copyright © 2018 BeesOnMars. All rights reserved.
//

import UIKit

class GameViewController: UIPageViewController, UIPageViewControllerDataSource{
    var currentIndex: Int = 0
    var currentTopic : Topic = Topic("")
    var questions : [Question] = []
    var mode: [Bool] = [false, false, true]
    var questionViewControllers : [QuestionViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self;
        loadTopic()
        if mode[1] {
            questions = currentTopic.getShuffledQuestions()
        } else {
            questions = currentTopic.questions
        }
        
        for i in 0..<questions.count{
            questionViewControllers.append(storyboard?.instantiateViewController(withIdentifier: "QuestionViewController") as! QuestionViewController);
            print(questions[i].question)
            questionViewControllers[i].Qindex = i;
            questionViewControllers[i].questionObj = questions[i];
            questionViewControllers[i].NumberOfPages = questions.count
            questionViewControllers[i].father = self
        }
        for i in 0..<questions.count{
            questionViewControllers[i].questionViewControllers = self.questionViewControllers
        }
        
        self.setViewControllers([questionViewControllers[0]], direction: .forward, animated: true, completion: nil)
    }
    
    
    func loadTopic(){
        if currentTopic.name != "" {
            return;
        }
        currentTopic.name = "Maths";
        currentTopic.addQuestion(question: "What is the square root of 4?", answers: ["2","4","8","16"], correctAnswer: 0);
        currentTopic.addQuestion(question: "2-12", answers: ["-10", "8", "10", "2"], correctAnswer: 0);
        currentTopic.addQuestion(question: "Is alessandro pro", answers: ["No", "Si", "Fa solo vedere", "Andrea è meglio"], correctAnswer: 0);
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let qIndex = (viewController as! QuestionViewController).Qindex;
        if qIndex < questionViewControllers.count-1 {
            return questionViewControllers[qIndex+1];
        } else {
            return nil;
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let qIndex = (viewController as! QuestionViewController).Qindex;
        if qIndex > 0 {
            return questionViewControllers[qIndex-1];
        } else {
            return nil;
        }
    }
    
    
}
