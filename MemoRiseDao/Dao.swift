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
    
    func addTopic(title: String) {
        
        let insertStatementString = "INSERT INTO Topic (Name) VALUES (?);"
        
        var insertStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            let name: NSString = title as NSString
            
            sqlite3_bind_text(insertStatement, 1, name.utf8String, -1, nil)

            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        // 5
        sqlite3_finalize(insertStatement)
    }
    
    
}
