//
//  TableDelegate.swift
//  MemoRise
//
//  Created by Alessandro Scala on 18/10/2018.
//  Copyright © 2018 BeesOnMars. All rights reserved.
//

import Foundation

protocol TableDelegate{
    func play(index: Int);
    func toggleFavorite(index: Int) -> Bool;
}
