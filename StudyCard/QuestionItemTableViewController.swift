//
//  QuestionItemTableViewController.swift
//  StudyCard
//
//  Created by Fiona Siu on 2018-03-01.
//  Copyright © 2018 Fiona Siu. All rights reserved.
//

import UIKit
import os

class QuestionItemTableViewController: UITableViewController {
    
    var lists = [QuestionItem]()
    let cellIdentifier = "QuestionItemTableViewCell"
    var questionName: String?
    var titleName: String?
    var correctValue: Int?
    var incorrectValue: Int?
    var currentFourthViewController: FourthViewController?
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        if let restored = loadItems2(){
            lists += restored
        }
        
        self.navigationItem.title = titleName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? QuestionItemTableViewCell else{
            fatalError("Selected cell is not of type \(cellIdentifier)")
        }
        
        let list = lists[indexPath.row]
        cell.questionTitle.text = list.questionName
        return cell
    }
    
    @IBAction func unwindToQuestionItemList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? SecondViewController, let list = sourceViewController.list {
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                lists[selectedIndexPath.row] = list
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else{
                let newIndexPath = IndexPath(row: lists.count, section: 0)
                lists.append(list)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        if let sourceViewController = sender.source as? FourthViewController, let correctValue = sourceViewController.correctValue, let incorrectValue = sourceViewController.incorrectValue {
            let selectedIndexPath = tableView.indexPathForSelectedRow
            lists[(selectedIndexPath?.row)!].correctValue = correctValue
            lists[(selectedIndexPath?.row)!].incorrectValue = incorrectValue
            tableView.reloadRows(at: [selectedIndexPath!], with: .none)
        }
        saveItems2()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            lists.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            saveItems2()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "ShowItem"{
            guard let tempViewController = segue.destination as? UINavigationController else{
                fatalError("Unexpected destination \(segue.destination)")
            }
            guard let detailViewController = tempViewController.topViewController as? ThirdViewController else{
                fatalError("Unexpected destination \(segue.destination)")
            }
            guard let selectedTableViewCell = sender as? QuestionItemTableViewCell else{
                fatalError("Unexpected destination \(String(describing: sender))")
            }
            guard let indexPath = tableView.indexPath(for: selectedTableViewCell) else{
                fatalError("Unexpected index path for \(selectedTableViewCell)")
            }
            detailViewController.list = lists[indexPath.row]

        }
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func saveItems2(){
        if !NSKeyedArchiver.archiveRootObject(lists, toFile: QuestionItem.archiveURL.path){
            os_log("Cannot save in %@", log: OSLog.default, type: .debug, QuestionItem.archiveURL.path)
        }
    }
    
    func loadItems2() ->[QuestionItem]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: QuestionItem.archiveURL.path) as? [QuestionItem]
    }
}
