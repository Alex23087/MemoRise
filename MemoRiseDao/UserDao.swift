//
//  UserDao.swift
//  MemoRise
//
//  Created by Daniele on 17/10/2018.
//  Copyright © 2018 BeesOnMars. All rights reserved.
//

import UIKit

class UserDao{
    
    let URL_SAVE_USER = "http://192.168.0.8/WebService/api/addUser.php"
    
    func storeUserOnline(_ user: User) { 
        
        let requestURL = NSURL(string: URL_SAVE_USER)
        let request = NSMutableURLRequest(url: requestURL! as URL)
        request.httpMethod = "POST"
        let userName = user.getName()
        let postParameters = "name="+userName;
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
    
    
}
