//
//  TopicTableViewCell.swift
//  MemoRise
//
//  Created by Alessandro Scala on 16/10/2018.
//  Copyright © 2018 BeesOnMars. All rights reserved.
//

import UIKit

class TopicTableViewCell: UITableViewCell {
    
    

    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
