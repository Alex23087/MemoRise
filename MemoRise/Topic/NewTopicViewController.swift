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
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            currentTopic.questions.remove(at: indexPath.row);
            tableView.deleteRows(at: [indexPath], with: .fade);
            tableView.reloadData();
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData();
    }
    
    @IBAction func onDone(_ sender: Any) {
        currentTopic.name = topicNameField.text ?? "";
        if currentTopic.name == "" || currentTopic.name.replacingOccurrences(of: " ", with: "") == ""{
            self.view.makeToast("Please specify a name for the topic");
            return;
        }
        if currentTopic.questionCount < 1 {
            self.view.makeToast("Please create at least one question");
            return;
        }
        topicDelegate?.saveTopic(topic: currentTopic, at: topicIndex);
        navigationController?.popViewController(animated: true);
    }
    
}
