//
//  UserViewController.swift
//  MemoRise
//
//  Created by Andrea La Veglia on 16/10/2018.
//  Copyright © 2018 BeesOnMars. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK:Properties
    @IBAction func ResetScore(_ sender: UIButton) {
    }
    
    @IBAction func ToggleNotificationSwitch(_ sender: UISwitch) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
