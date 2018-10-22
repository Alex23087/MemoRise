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
    var delegate: MainDelegate?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = name;
        surnameTextField.text = surname;
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

    @IBAction func onSave(_ sender: Any) {
        name = nameTextField.text;
        surname = surnameTextField.text;
        delegate?.setName(name: (nameTextField?.text ?? "") + " " + (surnameTextField?.text ?? ""));
        daoReference.updateTopic(topic: {let out = Topic("Persistence.User.Data"); out.addQuestion(question: "Data", answers: [name!, surname!], correctAnswer: 0); return out}()) //This thing is a shame, but we have no time
        navigationController?.popViewController(animated: true);
    }
    
    @IBAction func onReset(_ sender: Any) {
        let dialog = UIAlertController(title: "Are you sure?", message: "This operation cannot be undone", preferredStyle: .actionSheet)
        dialog.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        dialog.addAction(UIAlertAction(title: "Delete all data", style: .destructive, handler: { dial in
            daoReference.deleteAll()
            self.delegate?.resetTopics()
            self.nameTextField.text = ""
            self.surnameTextField.text = ""
            self.delegate?.setName(name: "")
            name = ""
            surname = ""
        }))
        self.present(dialog, animated: true)
    }
}
