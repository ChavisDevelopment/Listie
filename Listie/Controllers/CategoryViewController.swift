//
//  CategoryViewController.swift
//  Listie
//
//  Created by Seth Chavis on 1/17/18.
//  Copyright © 2018 Joseth Chavis. All rights reserved.
//

import UIKit
import CoreData
class CategoryViewController: UITableViewController{
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet var categoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        loadCategories()

    }
    //MARK: -  tableview datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let item = categories[indexPath.row]
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    //MARK: -  tableview delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if  let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    
    //MARK: -  data manipulation methods
    func saveCategories() {
        do {
            try context.save()
        }catch {
            print("There was an error saving the category \(error)")
        }
        UIView.transition(with: tableView,
                          duration: 0.1,
                          options: .transitionCrossDissolve,
                          animations: { self.tableView.reloadData()
                            
        })
    }
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categories = try context.fetch(request)
        }catch {
            print("Error fetching the request from categories \(error)")
        }
        UIView.transition(with: tableView,
                          duration: 0.1,
                          options: .transitionCrossDissolve,
                          animations: { self.tableView.reloadData()
                            
        })
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
         let newCategory = Category(context: self.context)
            newCategory.name = textField.text
            self.categories.append(newCategory)
            self.saveCategories()
            
        }
        alert.addAction(action)
        alert.addTextField { (field) in
        field.placeholder = "Add a new category"
        textField = field
        }
        present(alert, animated: true, completion: nil)
    }
 //MARK: -  tableView delegate methods
}
