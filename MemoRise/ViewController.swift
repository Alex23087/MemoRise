//
//  ViewController.swift
//  MemoRise
//
//  Created by Alessandro Scala on 12/10/2018.
//  Copyright © 2018 BeesOnMars. All rights reserved.


import UIKit
import SQLite3

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("memorise.sqlite")
        
        var db: OpaquePointer?
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error opening Database")
        } else {
            if sqlite3_exec(db, "create table if not exists questions(id integer primary key autoincrement,  question text, userid integer)", nil, nil, nil) != SQLITE_OK {
                print ("Error Creating table: " + String(cString: sqlite3_errmsg(db)!))
            }
        }
    }
}
