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
    var favorites: [Int]?;
    private var playIndex: Int = -1;
    var delegate: MainDelegate?;
    
    @IBOutlet weak var topicsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        cell.favButton.isSelected = topics?[indexPath.row].isFavorite ?? false;
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
        delegate?.moveTopic(from: sourceIndexPath.row, to: destinationIndexPath.row);
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delegate?.deleteTopic(name: topics![indexPath.row].name);
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
        delegate?.addTopic(topic: topic);
        topicsTable.reloadData();
    }
    
    func play(index: Int) {
        navigationController?.popViewController(animated: true);
        playIndex = index;
        performSegue(withIdentifier: "PlaySegue", sender: self);
    }
    
    func toggleFavorite(index: Int) -> Bool{
        if favorites == nil { favorites = []; }
        if let favInd = favorites?.firstIndex(of: index){
            favorites?.remove(at: favInd);
            topics?[index].isFavorite = false;
            delegate?.toggleFavorite(topicName: topics![index].name, fav: false);
            return false;
        } else {
            if favorites!.count < 3 {
                favorites?.append(index);
                topics?[index].isFavorite = true;
                delegate?.toggleFavorite(topicName: topics![index].name, fav: true);
                return true;
            } else {
                return false;
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        delegate?.reload();
    }
}
