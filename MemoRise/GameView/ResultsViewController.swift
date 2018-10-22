//
//  ResultsViewController.swift
//  MemoRise
//
//  Created by Raffaele Scala on 18/10/18.
//  Copyright © 2018 BeesOnMars. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet var result: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var res: String?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = name;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        result.text = res;
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    

}
