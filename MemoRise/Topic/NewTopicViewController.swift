//
//  NewTopicViewController.swift
//  MemoRise
//
//  Created by Raffaele Scala on 15/10/18.
//  Copyright © 2018 BeesOnMars. All rights reserved.
//

import UIKit

class NewTopicViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddQuestionDelegate {

    var currentTopic: Topic = Topic("");
    var topicIndex: Int = -1;
    private var selQuestion: Int = -1;
    var topicDelegate: TopicDelegate?;
    @IBOutlet weak var finishButton: UIBarButtonItem!
    private var edited: Bool = false {
        didSet{
            if (topicNameField.text == "" || topicNameField.text?.replacingOccurrences(of: " ", with: "") == "") && currentTopic.questionCount == 0 {
                edited = false;
            }
            finishButton.title = edited ? "Done" : "Cancel";
        }
    }
    
    @IBOutlet weak var topicNameField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self;
        tableView.delegate = self;
        topicNameField.text = currentTopic.name;
        if topicIndex != -1 {
            navigationItem.title = "Edit Topic";
        }
    }
    
    @IBAction func onEdit(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true);
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentTopic.questionCount;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell") as! QuestionTableViewCell;
        cell.numLabel.text = String(indexPath.row+1);
        cell.questionLabel.text = currentTopic.questions[indexPath.row].question;
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator;
        return cell;
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let element = currentTopic.questions.remove(at: sourceIndexPath.row);
        currentTopic.questions.insert(element, at: destinationIndexPath.row);
        tableView.reloadData();
        edited = true;
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            currentTopic.questions.remove(at: indexPath.row);
            tableView.deleteRows(at: [indexPath], with: .fade);
            tableView.reloadData();
            edited = true;
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selQuestion = indexPath.row;
        performSegue(withIdentifier: "EditQuestion", sender: self);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is AddQuestionViewController{
            let contr = segue.destination as! AddQuestionViewController;
            contr.topic = currentTopic;
            contr.questionNum = selQuestion;
            selQuestion = -1;
            contr.delegate = self;
        }
    }
    
    func addQuestion(question: Question, index: Int = -1) {
        if index == -1{
            currentTopic.addQuestion(question);
        }else{
            currentTopic.questions.remove(at: index);
            currentTopic.questions.insert(question, at: index);
        }
        edited = true;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData();
    }
    
    @IBAction func onDone(_ sender: Any) {
        currentTopic.name = topicNameField.text ?? "";
        if !edited {
            navigationController?.popViewController(animated: true);
        } else {
            if currentTopic.name == "" || currentTopic.name.replacingOccurrences(of: " ", with: "") == ""{
                let dialog = UIAlertController(title: "Your topic has no name", message: "Do you want to exit without saving?", preferredStyle: .actionSheet)
                dialog.addAction(UIAlertAction(title: "Continue Editing", style: .default, handler: nil))
                dialog.addAction(UIAlertAction(title: "Exit without saving", style: .destructive, handler: {dial in self.navigationController?.popViewController(animated: true)}))
                self.present(dialog, animated: true)
                return;
            }
            if currentTopic.questionCount < 1 {
                let dialog = UIAlertController(title: "You didn't add any questions", message: "Add at least one to save topic", preferredStyle: .actionSheet)
                dialog.addAction(UIAlertAction(title: "Add question", style: .default, handler: { dial in self.performSegue(withIdentifier: "EditQuestion", sender: self)}))
                dialog.addAction(UIAlertAction(title: "Exit without saving", style: .destructive, handler: {dial in self.navigationController?.popViewController(animated: true)}))
                self.present(dialog, animated: true)
                return;
            }
            if topicDelegate?.saveTopic(topic: currentTopic, at: topicIndex) ?? false{
                navigationController?.popViewController(animated: true);
            } else {
                self.view.makeToast("This topic already exists, please choose another name", position: .top)
            }
        }
    }
    
    @IBAction func nameEdited(_ sender: Any) {
        edited = true;
    }
}
