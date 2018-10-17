//
//  GameViewController.swift
//  MemoRise
//
//  Created by Raffaele Scala on 17/10/18.
//  Copyright © 2018 BeesOnMars. All rights reserved.
//

import UIKit

class GameViewController: UIPageViewController {
    var currentIndex: Int = 0
    var currentTopic : Topic = Topic("")
    var questions : [Question] = []
    var mode: [Bool] = [false, false, true]
    var questionViewControllers : [QuestionViewController] = []
    //0 tempo 1 random 2 navigazione
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTopic()
        if mode[1] {
            questions = currentTopic.getShuffledQuestions()
        } else {
            questions = currentTopic.questions
        }
        
        for i in 0..<questions.count{
            questionViewControllers.append(QuestionViewController())
            print(questions[i].question)
            questionViewControllers[i].loadQuestion(inQuestion: questions[i])
        }
        self.setViewControllers(questionViewControllers, direction: .forward, animated: true, completion: nil)
    }
    

    func loadTopic(){
        if currentTopic.name != "" {
            return;
        }
        currentTopic.name = "Maths";
        currentTopic.addQuestion(question: "What is the square root of 4?", answers: ["2","4","8","16"], correctAnswer: 0);
        currentTopic.addQuestion(question: "2-12", answers: ["-10", "8", "10", "2"], correctAnswer: 0);
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        guard let pagesCount = data?.filteredProfiles.count else {
//            return nil
//        }
//
//        guard let newIndex = (viewController as? ProfileViewController).index + 1, newIndex < pagesCount else {
//            return nil
//        }
//
//        let profile = ProfileViewController()
//        profile.profile = data?.filteredProfiles[newIndex]
//        profile.index = newIndex
//        return profile
        return questionViewControllers[viewController.Qindex + 1];
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let pagesCount = data?.filteredProfiles.count else {
            return nil
        }
        
        guard let newIndex = (viewController as? ProfileViewController).index - 1, newIndex >= 0 else {
            return nil
        }
        
        
        let profile = ProfileViewController()
        profile.profile = data?.filteredProfiles[newIndex!]
        profile.index = newIndex
        return profile
    }
}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
