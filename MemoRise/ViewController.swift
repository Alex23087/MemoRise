//
//  ViewController.swift
//  MemoRise
//
//  Created by Alessandro Scala on 12/10/2018.
//  Copyright © 2018 BeesOnMars. All rights reserved.


import UIKit
import SQLite3

var name: String?;
var surname: String?;

class ViewController: UIViewController, MainDelegate {
    
    @IBOutlet var favoriteTopics: [UIView]!
    @IBOutlet var favoriteTopicsLabel: [UILabel]!
    
    var topics: [Topic]?;

    var favorites: [Int] = [];
    var topicToPlay: Int = -1;
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    
    @IBAction func fav1(_ sender: Any) {
        topicToPlay = 0;
        performSegue(withIdentifier: "PlayFav", sender: self);
    }
    @IBAction func fav2(_ sender: Any) {
        topicToPlay = 1;
        performSegue(withIdentifier: "PlayFav", sender: self);
    }
    @IBAction func fav3(_ sender: Any) {
        topicToPlay = 2;
        performSegue(withIdentifier: "PlayFav", sender: self);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for fav in favoriteTopics {
            fav.layer.masksToBounds = true;
            fav.layer.cornerRadius = 23.5;
        }
        if topics == nil {
            loadTopics();
        }
        reload();
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
        //      CONNESSIONE SQLITE
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("memorise.sqlite")
        
        var db: OpaquePointer?
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error opening Database")
        } else {
            if sqlite3_exec(db, """
                CREATE TABLE IF NOT EXISTS Topic (
                ID integer PRIMARY KEY AUTOINCREMENT,
                Name text
                );

                CREATE TABLE IF NOT EXISTS Questions (
                    ID integer PRIMARY KEY AUTOINCREMENT,
                    TopicID text,
                    Question integer,
                    CorrectAns integer
                );

                CREATE TABLE IF NOT EXISTS Answers (
                    ID integer PRIMARY KEY AUTOINCREMENT,
                    QuestionID integer,
                    Answer text
                );

                """, nil, nil, nil) != SQLITE_OK {
                print ("Error Creating table: " + String(cString: sqlite3_errmsg(db)!))
            }
        }
        
    }
    
    func reload() {
        //navigationController?.setNavigationBarHidden(true, animated: true);
        favorites = [];
        for i in 0..<favoriteTopics.count {
            favoriteTopics[i].isHidden = true;
        }
        for i in 0 ..< (topics?.count ?? 0){
            if topics![i].isFavorite {
                favorites.append(i);
                if favorites.count == 3{
                    break;
                }
            }
        }
        for i in 0..<favorites.count {
            if i == 3 { break; }
            favoriteTopics[i].isHidden = false;
            favoriteTopicsLabel[i].text = topics?[favorites[i]].name ?? "Error";
        }
    }
    
    
    
    func loadTopics(){
        topics = [];
        var top: Topic = Topic("Maths");
        top.addQuestion(question: "What is the square root of 4?", answers: ["2","4","8","16"], correctAnswer: 0);
        top.addQuestion(question: "2-12", answers: ["-10", "8", "10", "2"], correctAnswer: 0);
        top.addQuestion(question: "Is alessandro pro", answers: ["No", "Si", "Fa solo vedere", "Andrea è meglio"], correctAnswer: 1);
        topics?.append(top);
        top = Topic("Maths");
        top.addQuestion(question: "What is the square root of 4?", answers: ["2","4","8","16"], correctAnswer: 0);
        top.addQuestion(question: "2-12", answers: ["-10", "8", "10", "2"], correctAnswer: 0);
        top.addQuestion(question: "Is alessandro pro", answers: ["No", "Si", "Fa solo vedere", "Andrea è meglio"], correctAnswer: 1);
        topics?.append(top);
        top = Topic("Maths");
        top.addQuestion(question: "What is the square root of 4?", answers: ["2","4","8","16"], correctAnswer: 0);
        top.addQuestion(question: "2-12", answers: ["-10", "8", "10", "2"], correctAnswer: 0);
        top.addQuestion(question: "Is alessandro pro", answers: ["No", "Si", "Fa solo vedere", "Andrea è meglio"], correctAnswer: 1);
        topics?.append(top);
        top = Topic("Maths");
        top.addQuestion(question: "What is the square root of 4?", answers: ["2","4","8","16"], correctAnswer: 0);
        top.addQuestion(question: "2-12", answers: ["-10", "8", "10", "2"], correctAnswer: 0);
        top.addQuestion(question: "Is alessandro pro", answers: ["No", "Si", "Fa solo vedere", "Andrea è meglio"], correctAnswer: 1);
        topics?.append(top);
        top = Topic("Maths");
        top.addQuestion(question: "What is the square root of 4?", answers: ["2","4","8","16"], correctAnswer: 0);
        top.addQuestion(question: "2-12", answers: ["-10", "8", "10", "2"], correctAnswer: 0);
        top.addQuestion(question: "Is alessandro pro", answers: ["No", "Si", "Fa solo vedere", "Andrea è meglio"], correctAnswer: 1);
        topics?.append(top);
        topics?[2].isFavorite = true;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is TopicsViewController {
            navigationController?.setNavigationBarHidden(false, animated: true)
            let dest = (segue.destination as! TopicsViewController);
            dest.topics = self.topics;
            dest.delegate = self;
        }
        if segue.destination is GameViewController {
            (segue.destination as! GameViewController).currentTopic = topics![favorites[topicToPlay]];
            topicToPlay = -1;
        }
        if segue.destination is UserViewController {
            navigationController?.setNavigationBarHidden(false, animated: true)
            let dest = segue.destination as! UserViewController;
            dest.delegate = self;
        }
    }
    
    func deleteTopic(name: String) {
        for i in 0 ..< (topics?.count ?? 0) {
            if topics?[i].name == name{
                topics?.remove(at: i);
                return;
            }
        }
    }
    
    func toggleFavorite(topicName: String, fav: Bool) {
        for i in 0 ..< (topics?.count ?? 0) {
            if topics?[i].name == topicName {
                topics?[i].isFavorite = fav;
                print("\(topics![i].name) \(fav)")
                return;
            }
        }
    }
    
    func addTopic(topic: Topic) {
        for i in 0 ..< (topics?.count ?? 0) {
            if topics?[i].name == topic.name{
                topics?.remove(at: i);
                topics?.insert(topic, at: i);
                return;
            }
        }
        topics?.append(topic);
    }
    
    func moveTopic(from: Int, to: Int) {
        let tmpTop = topics![from];
        topics?.remove(at: from);
        topics?.insert(tmpTop, at: to);
    }
    
    func setName(name: String) {
        nameLabel.text = name;
    }
    
    func setSurname(surname: String) {
        surnameLabel.text = surname;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
