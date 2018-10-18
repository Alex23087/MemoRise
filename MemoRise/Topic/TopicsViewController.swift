//
//  TopicsViewController.swift
//  MemoRise
//
//  Created by Alessandro Scala on 18/10/2018.
//  Copyright © 2018 BeesOnMars. All rights reserved.
//

import UIKit

class TopicsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TopicDelegate, TableDelegate {

    var topicIndex: Int = -1;
    var topics: [Topic]?;
    private var playIndex: Int = -1;
    
    @IBOutlet weak var topicsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTopics();
        topicsTable.delegate = self;
        topicsTable.dataSource = self;
    }
    
    @IBAction func toggleEdit(_ sender: Any) {
        topicsTable.isEditing = !topicsTable.isEditing;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell") as! TopicTableViewCell;
        cell.numberLabel.text = String(indexPath.row+1);
        cell.nameLabel.text = topics?[indexPath.row].name ?? "Error";
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator;
        cell.selectionStyle = UITableViewCell.SelectionStyle.none;
        cell.delegate = self;
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        topicIndex = indexPath.row;
        performSegue(withIdentifier: "NewTopicSegue", sender: self)
        topicIndex = -1;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is NewTopicViewController {
            let dest = (segue.destination as! NewTopicViewController);
            dest.topicIndex = topicIndex;
            dest.currentTopic = topicIndex == -1 ? Topic("") : topics?[topicIndex] ?? Topic("");
            dest.topicDelegate = self;
        } else if segue.destination is GameViewController {
            let dest = (segue.destination as! GameViewController);
            dest.currentTopic = topics?[playIndex] ?? Topic("");
        }
    }
    
    func loadTopics(){
        topics = [];
        let top: Topic = Topic("Maths");
        top.addQuestion(question: "What is the square root of 4?", answers: ["2","4","8","16"], correctAnswer: 0);
        top.addQuestion(question: "2-12", answers: ["-10", "8", "10", "2"], correctAnswer: 0);
        top.addQuestion(question: "Is alessandro pro", answers: ["No", "Si", "Fa solo vedere", "Andrea è meglio"], correctAnswer: 1);
        topics?.append(top);
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let top = topics![sourceIndexPath.row];
        topics?.remove(at: sourceIndexPath.row);
        topics?.insert(top, at: destinationIndexPath.row);
        topicsTable.reloadData();
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            topics?.remove(at: indexPath.row);
            topicsTable.deleteRows(at: [indexPath], with: .fade);
            topicsTable.reloadData();
        }
    }
    
    func saveTopic(topic: Topic, at index: Int) {
        if index == -1 {
            topics?.append(topic);
        } else {
            topics?.remove(at: index);
            topics?.insert(topic, at: index);
        }
        topicsTable.reloadData();
    }
    
    func play(index: Int) {
        navigationController?.popViewController(animated: true);
        playIndex = index;
        performSegue(withIdentifier: "PlaySegue", sender: self);
    }
}
