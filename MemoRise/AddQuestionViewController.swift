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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if questionNum == -1 {
            question = Question();
        }else{
            question = topic!.getQuestion(questionNum);
            
            textField.text = question!.question;
            for i in (0..<question!.answers.count){
                answerTextFields[i].text = question!.answers[i];
            }
            navBar.title = "Edit question";
        }
    }
    
    @IBAction func onSave(_ sender: Any) {
        question!.question = textField.text!;
        question?.answers = [String]();
        for i in (0..<4){
            if let ans = answerTextFields[i].text {
                question!.answers.append(ans);
            }
        }
        delegate?.addQuestion(question: question!, index: questionNum);
        self.navigationController?.popViewController(animated: true);
    }
}
