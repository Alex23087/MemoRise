//
//  Question.swift
//  MemoRise
//
//  Created by Alessandro Scala on 15/10/2018.
//  Copyright © 2018 BeesOnMars. All rights reserved.
//

import Foundation

class Question{
    private var text: String;
    private var answers: [Answer];
   
    
    init (_ question: String){
        
        self.text = question
        
    }
    
    func getText()->String{
        return self.text
    }
    
    func setText(_ question: String){
        self.text=question
    }
    
    func getAnswers()-> [Answer]{
        return self.answers
    }
    
    func setAnswers(_ answers: [Answer]){
        self.answers = answers
    }
    
    func clean(){
        var i = 0;
        while i < answers.count{
            if answers[i]=="" || (answers[i].replacingOccurrences(of: " ", with: "", options: String.CompareOptions.caseInsensitive) == ""){
                answers.remove(at: i);
                continue;
            }
            i = i+1;
        }
    }
    
    func containsProfanity() -> Bool{
        if question.containsProfanity(){
            return true;
        }
        for i in 0..<answers.count{
            if answers[i].containsProfanity(){
                return true;
            }
        }
        return false;
    }
    
    func shuffleAnswers() -> Question{
        let ans = answers[correctAnswer];
        answers.shuffle();
        correctAnswer = answers.firstIndex(of: ans)!;
        return self;
    }
}
