//
//  NewTopicViewController.swift
//  MemoRise
//
//  Created by Raffaele Scala on 15/10/18.
//  Copyright © 2018 BeesOnMars. All rights reserved.
//

import UIKit

class NewTopicViewController: UIViewController, UITableViewDataSource {

    var currentTopic: Topic = Topic("");
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self;
        loadTopic();
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell") as! TopicTableViewCell;
        cell.numLabel.text = String(indexPath.row);
        cell.questionLabel.text = currentTopic.questions[indexPath.row].question;
        return cell;
    }
    
    func loadTopic(){
        currentTopic.name = "Maths";
        currentTopic.addQuestion(question: "What is the square root of 4?", answers: ["2","4","8","16"], correctAnswer: 0);
        currentTopic.addQuestion(question: "2-12", answers: ["-10", "8", "10", "2"], correctAnswer: 0);
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let element = currentTopic.questions.remove(at: sourceIndexPath.row);
        currentTopic.questions.insert(element, at: destinationIndexPath.row);
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            currentTopic.questions.remove(at: indexPath.row);
            tableView.deleteRows(at: [indexPath], with: .fade);
        }
    }
}
