//
//  User.swift
//  MemoRise
//
//  Created by Daniele on 17/10/2018.
//  Copyright © 2018 BeesOnMars. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: String
    
    init(_ name: String) {
        self.name = name;
        
    }
    
    func getName()->String{
        return self.name
    }
    
    func setName(_ name: String){
        self.name = name
    }
}
