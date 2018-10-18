//
//  Question.swift
//  MemoRise
//
//  Created by Alessandro Scala on 15/10/2018.
//  Copyright © 2018 BeesOnMars. All rights reserved.
//

import Foundation

class Question{
    var question: String;
    var answers: [String];
    var correctAnswer: Int;
    var ID: Int;
    
    init(_ questionText: String = "", _ answers: [String] = [""], _ correctAnswer: Int = 0, ID: Int = -1){
        question = questionText;
        self.answers = answers;
        self.correctAnswer = correctAnswer;
        if ID == -1{
            self.ID = Int.random(in: 0...Int.max);
        }else{
            self.ID = ID;
        }
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
