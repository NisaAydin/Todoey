//
//  ViewController.swift
//  Todoey
//
//  Created by Nisa Aydin on 17.02.2024.
//

import UIKit
import RealmSwift

class TodoListViewController: SwipeTableViewController {
  
    var toDoItems : Results<Item>?
    // Results bir koleksiyon türüdür ve değişmezdir, yani içeriğine doğrudan eleman ekleyemezsiniz. Bunun yerine, veritabanına yeni bir nesne eklemek istediğinizde Realm'in write işlemi kullanılır.
    let realm = try! Realm()
    var selectedCategory : Category? {
        didSet{
          loadItems()
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight=60
    }
    
    // MARK: - TableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
    
        
        if let item = toDoItems?[indexPath.row]{
            cell.textLabel?.text=item.title
            // **** Ternary Operator *****
            // value = condition ? valueIfTrue : valueIfFalse
            cell.accessoryType = item.done ? .checkmark : .none
        }
        else {
            cell.textLabel?.text = "Not items added yet"
        }
        return cell
    }
    // MARK: - Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = toDoItems?[indexPath.row] {
            do{
                try realm.write {
                    item.done = !item.done
                }
                
            } catch {
                print("Error saving done status,\(error)")
            }
            
        }
        tableView.reloadData()
 
    }
    
    // MARK: - Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
   
            if let currentCategory = self.selectedCategory{
                do{
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }

                } catch {
                    print("Error saving new items,\(error)")
                }

            }
                self.tableView.reloadData()
          
           
            
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField=alertTextField
        }
       
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }

    
    func loadItems(){
        toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
        
   
        }
    // MARK: - Delete item
    override func updateModel(at indexPath: IndexPath) {
        if let itemToDelete = toDoItems?[indexPath.row]{
            do{
                try self.realm.write {
                    self.realm.delete(itemToDelete)
                    print("item deleted.")
                }
            }
            catch {
                print("Error deleting item: \(error)")
            }
           
        }
    }
        
    }

// MARK: - Search Bar Methods

extension TodoListViewController: UISearchBarDelegate {
 
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        toDoItems=toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
     // toDoItems koleksiyonunu filtreler ve belirtilen metni içeren title özelliğine sahip öğeleri alır. Daha sonra sorted fonksiyonu ile bu öğeleri title özelliğine göre alfabetik olarak sıralar.
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            DispatchQueue.main.async {
                
                self.loadItems()
                searchBar.resignFirstResponder()
                // klavyeyi kapatır.
            }
  
        }
      
      
        
    }
    
    
    
}


