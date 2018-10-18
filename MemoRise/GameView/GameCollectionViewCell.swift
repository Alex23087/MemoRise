//
//  CollectionViewCell.swift
//  MemoRise
//
//  Created by Raffaele Scala on 18/10/18.
//  Copyright © 2018 BeesOnMars. All rights reserved.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    var delegate : GameDelegate?
    @IBOutlet var buttonNumber: UIButton!
    var pageIndex: Int?;
    
    @IBAction func onClick(_ sender: Any) {
        delegate?.move(index: self.pageIndex!)
    }
}
