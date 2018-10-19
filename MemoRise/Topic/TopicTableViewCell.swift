//
//  TopicTableViewCell.swift
//  MemoRise
//
//  Created by Alessandro Scala on 18/10/2018.
//  Copyright © 2018 BeesOnMars. All rights reserved.
//

import UIKit

class TopicTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    var delegate: TableDelegate?;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btn.addTarget(self, action: #selector(playTouch), for: .touchUpInside);
        favButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside);
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func playTouch() {
        print("It works")
        delegate?.play(index: Int(numberLabel.text!)!-1);
    }
    
    @objc func toggleFavorite(){
        delegate?.toggleFavorite(index: Int(numberLabel.text!)!-1);
    }
}
