//
//  GameViewController.swift
//  MemoRise
//
//  Created by Raffaele Scala on 17/10/18.
//  Copyright © 2018 BeesOnMars. All rights reserved.
//

import UIKit

class GameViewController: UIPageViewController, UIPageViewControllerDataSource, GameDelegate{
    
    var currentTopic : Topic = Topic("")
    var questions : [Question] = []
    var mode: [Bool] = [false, false, true]
    var correctAnswers: [Bool] = []
    
    var questionViewControllers : [QuestionViewController] = []
    var questionNum: Int {
        get{
            return questions.count;
        }
    }
    var currentIndex: Int{
        get{
            return (viewControllers![0] as! QuestionViewController).Qindex;
        }
    }

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
            questionViewControllers[i].questionObj = questions[i].shuffleAnswers();
            questionViewControllers[i].NumberOfPages = questions.count
            questionViewControllers[i].delegate = self
            correctAnswers.append(false)
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
        currentTopic.addQuestion(question: "Is alessandro pro", answers: ["No", "Si", "Fa solo vedere", "Andrea è meglio"], correctAnswer: 1);
        print("test")
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
    
    func move(index: Int) {
        if index == currentIndex { return; }
        var direction: UIPageViewController.NavigationDirection?;
        if index > currentIndex {
            direction = .forward;
        } else {
            direction = .reverse;
        }
        if index < 0 || index > questionNum { return; }
        self.setViewControllers([questionViewControllers[index]], direction: direction!, animated: true, completion: nil);
    }
    
    func setAnswer(index: Int, result: Bool) {
        correctAnswers[index] = result;
    }
    
    func getScore() -> Int{
        var sum = 0
        for i in 0..<correctAnswers.count{
            if correctAnswers[i] {
                sum += 1
            }
        }
        return sum
    }
}
