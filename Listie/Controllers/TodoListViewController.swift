//
//  ViewController.swift
//  Listie
//
//  Created by Seth Chavis on 1/11/18.
//  Copyright © 2018 Joseth Chavis. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{

    
    var itemArray = [Item]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let newItem = Item()
        newItem.title = "Buy Eggs"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Waffles"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Buy Grits"
        itemArray.append(newItem3)
    if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        //Ternary Operator
        // Value = condition ? ValueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : . none

        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done  = !itemArray[indexPath.row].done
        
       tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //Mark - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Listie item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //What will happen when user click add item button
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
        }
        //Creates textfield in alert
        alert.addTextField(configurationHandler: { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            print("Now")
        })
        //Presnets the alert
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
}

