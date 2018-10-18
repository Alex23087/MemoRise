//
//  GameDelegate.swift
//  MemoRise
//
//  Created by Alessandro Scala on 18/10/2018.
//  Copyright © 2018 BeesOnMars. All rights reserved.
//

import UIKit
import Foundation

protocol GameDelegate {
    var questionNum: Int {get}
    var currentIndex: Int {get}
    func move(index: Int);
}
