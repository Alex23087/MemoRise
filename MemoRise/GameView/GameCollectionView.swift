//
//  Game.swift
//  MemoRise
//
//  Created by Raffaele Scala on 18/10/18.
//  Copyright © 2018 BeesOnMars. All rights reserved.
//

import UIKit

class GameCollectionView: UICollectionView, UICollectionViewDataSource {
    
    var gameDelegate : GameDelegate?
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameDelegate!.questionNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GameCollectionViewCell;
        cell.pageIndex = indexPath.row;
        cell.delegate = gameDelegate;
        cell.buttonNumber.setTitle(String(indexPath.row), for: .normal)
        if gameDelegate!.currentIndex == indexPath.row {
            cell.buttonNumber.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        } else {
            cell.buttonNumber.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        cell.buttonNumber.layer.masksToBounds = true;
        cell.buttonNumber.layer.cornerRadius = /*cell.buttonNumber.layer.visibleRect*/ 15;
        return cell;
    }
    

}
