//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Nisa Aydin on 21.02.2024.
//

import UIKit
import RealmSwift

class CategoryViewController: SwipeTableViewController {
  
    
    let realm = try! Realm()
    
    
    var categoriesArray : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight=80
        loadCategory()
  
    }
    // MARK: - Table View Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray?.count ?? 1
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text=categoriesArray?[indexPath.row].name ?? "No categories added yet."
        return cell
        
    }
    
    // MARK: - Table View Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
           
            destinationVC.selectedCategory = categoriesArray?[indexPath.row]
        }
    }

    // MARK: - Add new Categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Categories", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add category", style: .default) { action in
            let newCategory = Category()
            newCategory.name=textField.text!
            self.save(category: newCategory)
            
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new Category"
            textField=alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - Data Manipulation methods
    
    func save(category: Category){
        do{
            try realm.write {
                realm.add(category)
            }
            
        } catch{
            print("Error saving context")
            
        }
            tableView.reloadData()
        
    }
    func loadCategory(){
        
         categoriesArray = realm.objects(Category.self)

    }
    
    // MARK: - Delete data from swipe
    override func updateModel(at indexPath: IndexPath) {
        if let categoryToDelete = self.categoriesArray?[indexPath.row]{
            do {
                try self.realm.write {
                    self.realm.delete(categoryToDelete)
                    print("Item deleted succesfully.")
                }

            }
            catch{
                print("Error deleting item: \(error)")
            }
        }
    }
    
    
}
