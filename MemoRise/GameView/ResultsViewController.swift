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
    var res: String?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        result.text = res;
    }
    

}
