//
//  TopicDao.swift
//  MemoRise
//
//  Created by Raffaele Scala on 19/10/18.
//  Copyright © 2018 BeesOnMars. All rights reserved.
//

import Foundation
import SQLite3

let daoReference = Dao();

class Dao {
    
    var db: OpaquePointer?
    
    init(){
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("memorise.sqlite")
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error opening Database")
        }
        
    }
    
    func getTopicId(name: String) -> Int {
        let title: NSString = name as NSString
        let getIdTopicStatementString = "SELECT id FROM Topic WHERE Name = ?;"
        var getIdTopicStatement: OpaquePointer? = nil
        var topicID : Int32?
        
        if sqlite3_prepare_v2(db, getIdTopicStatementString, -1, &getIdTopicStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(getIdTopicStatement, 1, title.utf8String, -1, nil)
            while (sqlite3_step(getIdTopicStatement) == SQLITE_ROW) {
                topicID =  sqlite3_column_int(getIdTopicStatement, 0)
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(getIdTopicStatement)
        
        if(topicID != nil){
            return Int(String(topicID!))!
        } else {
            return -1
        }
    }

    func addTopic(topic: Topic) {
        
        let insertTopicStatementString = "INSERT INTO Topic (Name) VALUES (?);"
        
        var insertTopicStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertTopicStatementString, -1, &insertTopicStatement, nil) == SQLITE_OK {
            let name: NSString = topic.name as NSString
            
            sqlite3_bind_text(insertTopicStatement, 1, name.utf8String, -1, nil)

            if sqlite3_step(insertTopicStatement) == SQLITE_DONE {
                print("Successfully inserted Topic.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertTopicStatement)
        
        let questions = topic.questions
        

        let topicID = getTopicId(name: topic.name)
        
        for i in 0..<questions.count {
            
            let insertQuestionStatementString = "INSERT INTO Questions (TopicID, Question, CorrectAns) VALUES (?, ?, ?);"
            
            var insertQuestionStatement: OpaquePointer? = nil
            
            if sqlite3_prepare_v2(db, insertQuestionStatementString, -1, &insertQuestionStatement, nil) == SQLITE_OK {
                print("Ecco il topicID\(topicID)")
                let question: NSString = topic.questions[i].question as NSString
                let correctAns = topic.questions[i].correctAnswer
                
                sqlite3_bind_text(insertQuestionStatement, 2, question.utf8String, -1, nil)
                sqlite3_bind_text(insertQuestionStatement, 3, String(correctAns), -1, nil)
                sqlite3_bind_text(insertQuestionStatement, 1, String(topicID), -1, nil)
                
                if sqlite3_step(insertQuestionStatement) == SQLITE_DONE {
                    print("Successfully inserted Questions.")
                } else {
                    print("Could not insert row.")
                }
            } else {
                print("INSERT statement could not be prepared.")
            }
            sqlite3_finalize(insertQuestionStatement)
            
            
            let lastRowA = sqlite3_last_insert_rowid(db)
            
            for n in 0..<questions[i].answers.count {
                
                let insertAnswerStatementString = "INSERT INTO Answers (QuestionID, Answer) VALUES (?, ?);"
                
                var insertAnswerStatement: OpaquePointer? = nil
                
                if sqlite3_prepare_v2(db, insertAnswerStatementString, -1, &insertAnswerStatement, nil) == SQLITE_OK {
                    let answerID = lastRowA
                    let question: NSString = topic.questions[i].answers[n] as NSString
                    
                    sqlite3_bind_text(insertAnswerStatement, 1, String(answerID), -1, nil)
                    sqlite3_bind_text(insertAnswerStatement, 2, question.utf8String, -1, nil)
                    
                    if sqlite3_step(insertAnswerStatement) == SQLITE_DONE {
                        print("Successfully inserted Answers.")
                    } else {
                        print("Could not insert row.")
                    }
                } else {
                    print("INSERT statement could not be prepared.")
                }
                sqlite3_finalize(insertAnswerStatement)
                
            }
        }
    }
    
    func getQuestionIDfromTopic(name: String) -> [Int]{
        
        let topicID: Int = getTopicId(name: name)
        var questionsId : [Int] = []
        var statement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, "select ID from Questions WHERE TopicID = \(topicID)", -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
        }
        
        while sqlite3_step(statement) == SQLITE_ROW {
            let id = sqlite3_column_int64(statement, 0)
            questionsId.append(Int(String(id))!)
        }
        
        if sqlite3_finalize(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error finalizing prepared statement: \(errmsg)")
        }
        return questionsId
        
        
//        let topicID: Int = getTopicId(name: name)
//        var questionsId : [Int] = []
//
//        let getQuestionIDStatementString = "SELECT ID FROM Questions WHERE TopicID = ?;"
//        var getQuestionIDStatement: OpaquePointer? = nil
//
//        if sqlite3_prepare_v2(db, getQuestionIDStatementString, -1, &getQuestionIDStatement, nil) == SQLITE_OK {
//
//            sqlite3_bind_text(getQuestionIDStatement, 1, String(topicID), -1, nil)
//            while(sqlite3_step(getQuestionIDStatement) <= SQLITE_ROW){
//                    questionsId.append(Int(String(sqlite3_column_int(getQuestionIDStatement, 0)))!)
//                    print(sqlite3_column_int(getQuestionIDStatement, 0))
//            }
//                    sqlite3_finalize(getQuestionIDStatement)
//
//        } else {
//            print("SELECT statement could not be prepared")
//        }
//
//
//        return questionsId
    }
    
    func deleteTopic(name: String){
        let removeQuestion = getTopicId(name: name)
        let removeAnswers = getQuestionIDfromTopic(name: name)

        let deleteTopicStatementString = "DELETE FROM Topic WHERE id = ?;"

        var deleteTopicStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, deleteTopicStatementString, -1, &deleteTopicStatement, nil) == SQLITE_OK {

            sqlite3_bind_text(deleteTopicStatement, 1, String(getTopicId(name: name)), -1, nil)

            if sqlite3_step(deleteTopicStatement) == SQLITE_DONE {
                print("Successfully deleted Topic.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("DELETE statement could not be prepared.")
        }
        let deleteQuestionsStatementString = "DELETE FROM Questions WHERE TopicID = ?;"

        var deleteQuestionsStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, deleteQuestionsStatementString, -1, &deleteQuestionsStatement, nil) == SQLITE_OK {

            sqlite3_bind_text(deleteQuestionsStatement, 1, String(removeQuestion), -1, nil)

            if sqlite3_step(deleteQuestionsStatement) == SQLITE_DONE {
                print("Successfully deleted Questions.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("DELETE statement could not be prepared.")
        }
        for i in 0..<removeAnswers.count{
            let deleteAnswersStatementString = "DELETE FROM Answers WHERE QuestionID = ?;"

            var deleteAnswersStatement: OpaquePointer? = nil

            if sqlite3_prepare_v2(db, deleteAnswersStatementString, -1, &deleteAnswersStatement, nil) == SQLITE_OK {

                sqlite3_bind_text(deleteAnswersStatement, 1, String(removeAnswers[i]), -1, nil)

                if sqlite3_step(deleteAnswersStatement) == SQLITE_DONE {
                    print("Successfully deleted Questions.")
                } else {
                    print("Could not insert row.")
                }
            } else {
                print("DELETE statement could not be prepared.")
            }
        }


    }
    
}
