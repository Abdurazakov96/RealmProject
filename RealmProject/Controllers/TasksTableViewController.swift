//
//  TasksTableViewController.swift
//  RealmProject
//
//  Created by Магомед Абдуразаков on 11/10/2019.
//  Copyright © 2019 Магомед Абдуразаков. All rights reserved.
//

import UIKit
import RealmSwift


class TasksTableViewController: UITableViewController {
    
    
    //MARK: Public properties
    
    var tasksList: Results<Tasks>!
    
    
    //MARK: Overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        tasksList = realm.objects(Tasks.self)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TasksCell")
        cell?.textLabel?.text = tasksList[indexPath.row].name
        
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard  segue.identifier == "segue"  else {return}
        
        let selectedIndexPath = tableView.indexPathForSelectedRow
        let destination = segue.destination as? TaskTableViewController
        destination?.tasks = tasksList![(selectedIndexPath?.row)!]
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (_, _) in
            let alert = UIAlertController(title: "Edit Task", message: "Write new name Task", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: {action in
                let textfield = alert.textFields
                guard   textfield![0].text != nil else {return}
                let realm = try! Realm()
                
                try! realm.write {
                    self.tasksList[indexPath.row].name = textfield![0].text!
                    tableView.reloadData()
                }
            })
            
            let cancel = UIAlertAction(title: "Отмена", style: .cancel)
            
            alert.addTextField{textfield in textfield.keyboardType = .numberPad}
            alert.addAction(action)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
            
        }
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, _) in
            
            let realm = try! Realm()
            
            try! realm.write {
                realm.delete(self.tasksList[indexPath.row])
                tableView.reloadData()
            }
            
        }
        return ([editAction, deleteAction])
        
    }
    
    
    //MARK: IBAction
    @IBAction func addTask(_ sender: Any) {
        let alert = UIAlertController(title: "Write tasks name", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {action in
            
            let textfield = alert.textFields
            guard   textfield![0].text != nil else {return}
            let task = Tasks()
            task.name = textfield![0].text!
            let realm = try! Realm()
            
            
            try! realm.write {
                realm.add(task)
                self.tableView.reloadData()
            }
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addTextField{textfield in textfield.keyboardType = .default}
        alert.addAction(action)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

