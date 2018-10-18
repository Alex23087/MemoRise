//
//  TopicDao.swift
//  MemoRise
//
//  Created by Daniele on 17/10/2018.
//  Copyright © 2018 BeesOnMars. All rights reserved.
//

import UIKit
import SQLite3

class TopicDao {
    
    let URL_SAVE_TOPIC = "http://192.168.0.8/WebService/api/addTopic.php"
    
    func storeTopicOnline(_ topic: Topic) {
        
        let requestURL = NSURL(string: URL_SAVE_TOPIC)
        let request = NSMutableURLRequest(url: requestURL! as URL)
        request.httpMethod = "POST"
        let topicName=topic.getName()
        let postParameters = "name="+topicName;
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            if error != nil{
                print("error is \(String(describing: error))")
                return;
            }
            
            do {
                let myJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                if let parseJSON = myJSON {
                    var msg : String!
                    msg = parseJSON["message"] as! String?
                    print(msg)
                }
            } catch {
                print(error)
            }
            
        }
        task.resume()
    }
    
    
    func storeTopicOffline(_ topic: Topic){
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("memorise.sqlite")
        var db: OpaquePointer?
        var stmt: OpaquePointer?
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error opening Database")
        }else {
            if sqlite3_prepare(db, "insert into Topic (name) values(?)", -1, &stmt,nil) != SQLITE_OK {
                print ("Error binding query")
            }
            if sqlite3_bind_text(stmt, 1, topic.getName(), -1, nil) != SQLITE_OK {
                print("Error binding name")
            }
            
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("Topic stored successfully")
            }
            
        }
    }
    
    
}
