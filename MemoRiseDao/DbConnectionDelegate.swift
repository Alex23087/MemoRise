//
//  DbConnection.swift
//  MemoRise
//
//  Created by Raffaele Scala on 19/10/18.
//  Copyright © 2018 BeesOnMars. All rights reserved.
//

import UIKit
import Foundation

protocol DbConnectionDelegate {
    var dbConn : OpaquePointer? {get}
    
}
