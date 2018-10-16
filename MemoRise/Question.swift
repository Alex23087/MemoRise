//
//  Question.swift
//  MemoRise
//
//  Created by Alessandro Scala on 15/10/2018.
//  Copyright © 2018 BeesOnMars. All rights reserved.
//

import Foundation

struct Question{
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
}
