//
//  ClassItemTableViewController.swift
//  StudyCard
//
//  Created by Fiona Siu on 2018-03-01.
//  Copyright © 2018 Fiona Siu. All rights reserved.
//

import UIKit
import os

class ClassItemTableViewController: UITableViewController {

    //MARK: Properties
    var items = [ClassItem]()
    let cellIdentifier = "ClassItemTableViewCell"
    var className: String?
    
    
    //MARK: Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()

        if let restored = loadItems(){
            items += restored
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ClassItemTableViewCell else{
            fatalError("Selected cell is not of type \(cellIdentifier)")
        }

        let item = items[indexPath.row]
        cell.classTitle.text = item.classItem
        return cell
    }
    
    @IBAction func unwindToClassItemList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? ViewController, let item = sourceViewController.item {
            let newIndexPath = IndexPath(row: items.count, section: 0)
            items.append(item)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        saveItems()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            saveItems()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "ShowQuestion"{
            
            guard let tempViewController = segue.destination as? UINavigationController else{
                fatalError("Unexpected destination \(segue.destination)")
            }

            guard let detailViewController = tempViewController.topViewController as? QuestionItemTableViewController else{
                fatalError("Unexpected destination \(segue.destination)")
            }
            guard let selectedTableViewCell = sender as? ClassItemTableViewCell else{
                fatalError("Unexpected destination \(String(describing: sender))")
            }
            guard let indexPath = tableView.indexPath(for: selectedTableViewCell) else{
                fatalError("Unexpected index path for \(selectedTableViewCell)")
            }
            detailViewController.titleName = items[indexPath.row].classItem
        }
    }
    
    func saveItems(){
        if !NSKeyedArchiver.archiveRootObject(items, toFile: ClassItem.archiveURL.path){
            os_log("Cannot save in %@", log: OSLog.default, type: .debug, ClassItem.archiveURL.path)
        }
    }
    
    func loadItems() ->[ClassItem]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: ClassItem.archiveURL.path) as? [ClassItem]
    }
}
