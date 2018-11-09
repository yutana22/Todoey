//
//  ViewController.swift
//  Todoey
//
//  Created by r.yutana on 11/7/18.
//  Copyright © 2018 original. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
//    var keyListArray = "TodoListArray"
    var itemArray = [Item]()

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    let dataPathFile = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
//        let newItem = Item()
//        newItem.done = false
//        newItem.title = "item 1"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.done = false
//        newItem2.title = "item 2"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.done = false
//        newItem3.title = "item 3"
//        itemArray.append(newItem3)
        
        loadData()
//        if let item = userDefaults.array(forKey: keyListArray) as? [Item] {
//            itemArray = item
//        }
//
    }

    // Mark TableView DataSource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Item to Todoey ", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add New Item", style: .default) { (action) in
            
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            
            self.saveItems()
            
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = " Create new Item here"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems () {
        
        do {
            try context.save()
        } catch {
            print("Error \(error)")
        }
    }
    
    func loadData(){
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemArray =  try context.fetch(request)
        } catch {
            print("Fetch Error \(error)")
        }
    }
 
}

