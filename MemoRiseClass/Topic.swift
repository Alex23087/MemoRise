//
//  Topic.swift
//  MemoRise
//
//  Created by Alessandro Scala on 15/10/2018.
//  Copyright © 2018 BeesOnMars. All rights reserved.
//

import Foundation

class Topic{
    var name: String;
    var questions: [Question];
    
    var questionCount: Int {    //Ok, this is pretty useless, but I wanted to try computed vars
        get{
            return questions.count;
        }
    };
    
    convenience init(_ name: String){
		self.init(name, questions: [Question]());
    }
	
	init(_ name: String, questions: [Question]){
		self.name = name;
		self.questions = questions;
	}
    
    func addQuestion(_ question: Question){
        questions.append(question);
    }
    
    func addQuestion(question: String, answers: [String], correctAnswer: Int){
        addQuestion(Question(question, answers, correctAnswer));
    }
	
	func getName()->String{
		return self.name
	}
    
    func getQuestion(_ index: Int) -> Question{
        return questions[index];
    }
    
    func getRandomQuestion() -> Question{
        return getQuestion(Int.random(in: 0...questionCount));
    }
    
    func getShuffledQuestions() -> [Question]{
        return questions.shuffled();
    }
}
