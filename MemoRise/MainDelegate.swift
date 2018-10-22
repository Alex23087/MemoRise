//
//  MainDelegate.swift
//  MemoRise
//
//  Created by Alessandro Scala on 19/10/2018.
//  Copyright © 2018 BeesOnMars. All rights reserved.
//

import Foundation

protocol MainDelegate {
    func deleteTopic(name: String);
    func toggleFavorite(topicName: String, fav: Bool);
    func addTopic(topic: Topic);
    func moveTopic(from: Int, to: Int);
    func reload();
    func setName(name: String);
    func setSurname(surname: String);
}
