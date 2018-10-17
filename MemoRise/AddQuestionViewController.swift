//
//  AddQuestionViewController.swift
//  MemoRise
//
//  Created by Alessandro Scala on 17/10/2018.
//  Copyright © 2018 BeesOnMars. All rights reserved.
//

import UIKit

class AddQuestionViewController: UIViewController {
    
    var topic: Topic?;
    var questionNum: Int = -1;
    
    var question: Question?;

    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet var answerTextFields: [UITextField]!
    
    var delegate: AddQuestionDelegate?;
    
    
    @IBOutlet var correctButtons: [AlternativeButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for x in 0..<4{     //This sets for each button references to the others
            correctButtons[x].alternateButton = [];
            for y in 0..<4{
                if x != y{
                    correctButtons[x].alternateButton?.append(correctButtons[y]);
                }
            }
        }
        
        if questionNum == -1 {
            question = Question();
        }else{
            question = topic!.getQuestion(questionNum);
            
            textField.text = question!.question;
            for i in (0..<question!.answers.count){
                answerTextFields[i].text = question!.answers[i];
            }
            navBar.title = "Edit question";
            correctButtons[question!.correctAnswer].unselectAlternateButtons();
        }
    }
    
    @IBAction func onSave(_ sender: Any) {
        question!.question = textField.text!;
        question!.answers = [String]();
        for i in (0..<4){
            if let ans = answerTextFields[i].text{
                if ans != ""{
                    question!.answers.append(ans);
                }
            }
        }
        question!.clean();
        if question!.answers.count < 2 {
            self.view.makeToast("You need to specify at least two answers");
            return;
        }
        if question!.containsProfanity() {
            self.view.makeToast("This is a christian minecraft server, no swearing please");
            return;
        }
        question!.correctAnswer = -1;
        for i in 0..<4{
            if correctButtons[i].isSelected{
                if i<question!.answers.count && question!.answers[i] == answerTextFields[i].text{
                    question!.correctAnswer = i;
                    break;
                } else {
                    if let correctAnswer = answerTextFields[i].text{
                        question!.correctAnswer = question!.answers.firstIndex(of: correctAnswer) ?? -1;
                        break;
                    }else{
                        //Display toast, empty answer was ticked as correct
                        self.view.makeToast("Empty answer ticked as correct");
                    }
                }
            }
        }
        if question!.correctAnswer == -1{
            //Display toast, empty answer was ticked as correct
            self.view.makeToast("Empty answer ticked as correct");
        }else{
            delegate?.addQuestion(question: question!, index: questionNum);
            self.navigationController?.popViewController(animated: true);
        }
    }
}
