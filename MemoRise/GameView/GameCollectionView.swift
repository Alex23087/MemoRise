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
    var ind: Int = -1;
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameDelegate!.questionNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GameCollectionViewCell;
        cell.pageIndex = indexPath.row;
        cell.delegate = gameDelegate;
        cell.buttonNumber.setTitle(String(indexPath.row+1), for: .normal)
        if ind == indexPath.row {
            cell.buttonNumber.backgroundColor = #colorLiteral(red: 0, green: 0.4500676394, blue: 0.6861290336, alpha: 1);
            cell.buttonNumber.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal);
        } else {
            cell.buttonNumber.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1);
            cell.buttonNumber.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal);
        }
        cell.buttonNumber.layer.masksToBounds = true;
        cell.buttonNumber.layer.cornerRadius = /*cell.buttonNumber.layer.visibleRect*/ 15;
        return cell;
    }
    

}
