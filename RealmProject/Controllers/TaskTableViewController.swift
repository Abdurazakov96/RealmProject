//
//  TaskTableViewController.swift
//  RealmProject
//
//  Created by Магомед Абдуразаков on 11/10/2019.
//  Copyright © 2019 Магомед Абдуразаков. All rights reserved.
//

import UIKit
import RealmSwift


class TaskTableViewController: UITableViewController {
    
    
    //MARK: Public properties
    
    var tasks: Tasks!
    
    
    //MARK: Overriden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = tasks.name
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell")
        cell?.textLabel?.text = tasks.tasks[indexPath.row].name
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (_, _) in
            let alert = UIAlertController(title: "Edit Task", message: "Write new name Task", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: {action in
                let textfield = alert.textFields
                guard   textfield![0].text != nil else {return}
                let realm = try! Realm()
                try! realm.write {
                    self.tasks.tasks[indexPath.row].name = textfield![0].text!
                    tableView.reloadData()
                }
            })
            let cancel = UIAlertAction(title: "Отмена", style: .cancel)
            
            alert.addTextField{textfield in textfield.keyboardType = .default}
            alert.addAction(action)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (_, _) in
            
            let realm = try! Realm()
            
            
            try! realm.write {
                realm.delete(self.tasks.tasks[indexPath.row])
                tableView.reloadData()
            }
            
        }
        return ([editAction, deleteAction])
    }
    
    //MARK: Public methods
    
    @IBAction func addAction(_ sender: Any) {
        let alert = UIAlertController(title: "Write task name", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {action in
            
            let textfield = alert.textFields
            guard   textfield![0].text != nil else {return}
            
            let taskName = Task()
            
            taskName.name = textfield![0].text!
            let realm = try! Realm()
            
            try! realm.write {
                self.tasks.tasks.append(taskName)
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
