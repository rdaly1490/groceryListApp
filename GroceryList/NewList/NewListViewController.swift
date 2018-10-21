//
//  NewListViewController.swift
//  GroceryList
//
//  Created by Rob Daly on 10/13/18.
//  Copyright © 2018 Rob Daly. All rights reserved.
//

import UIKit

class NewListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveList))
        self.title = "New List"
        self.textField.delegate = self
        self.textField.text = self.viewModel.placeholderText
        self.textField.textColor = UIColor.lightGray
//        self.textField.placeholder
        // Do any additional setup after loading the view.
    }
    
    let coreDataController = CoreDataController.sharedInstance
    
    private var groceryList: GroceryList?
    
    @objc func saveList() {
        let listItems = self.viewModel.text.components(separatedBy: CharacterSet.newlines)
        let groceryList = GroceryList(context: self.coreDataController.context)
        groceryList.createdDate = Date()
        groceryList.title = self.getFormattedDate()
        var groceryListItems = [GroceryListItem]()
        
        listItems.forEach {
            let listItem = GroceryListItem(context: self.coreDataController.context)
            listItem.grocery = self.findGroceryMatchInCoreData(listItem: $0)
            listItem.isComplete = false
            listItem.itemText = $0
            listItem.list = groceryList
            groceryListItems.append(listItem)
        }
        groceryList.items = NSSet(array: groceryListItems)
        self.coreDataController.saveContext()
        self.groceryList = groceryList
        //TODO: in core data search also check the plural form
        performSegue(withIdentifier: "groceryListSegue", sender: self)
    }
    
    private func findGroceryMatchInCoreData(listItem: String) -> Grocery {
        var grocery: Grocery
        if let exactMatch = self.coreDataController.fetchGrocery(from: listItem)?.first {
            grocery = exactMatch
        } else if let similarMatch = self.coreDataController.fetchSimilarGrocery(from: listItem)?.first {
            grocery = similarMatch
        } else if let similarPluralMatch = self.coreDataController.fetchSimilarGrocery(from: listItem + "s")?.first {
            grocery = similarPluralMatch
        } else {
            grocery = Grocery(context: self.coreDataController.context)
            grocery.name = listItem
            grocery.type = Int16(GroceryType.unknown.rawValue)
        }
        return grocery
    }
    
    private func getFormattedDate() -> String {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: Date()) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "MMM-dd-yyyy"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        
        return myStringafd
    }
    
    @IBOutlet weak var textField: UITextView!
    
    var viewModel = NewListViewModel()
    
    private func updateViewModel() {
        self.viewModel.text = self.textField.text
        self.viewModel.hasChanges = !self.textField.text.isEmpty && self.textField.text != self.viewModel.placeholderText
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "groceryListSegue" {
            if let groceryListViewController = segue.destination as? GroceryListViewController, let _groceryList = self.groceryList {
                groceryListViewController.groceryList = _groceryList
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewListViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = self.viewModel.placeholderText
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
//        if (textView.text == "") {
//            self.textField.text = self.viewModel.placeholderText
//        }
        
        let newText = ((textView.text ?? "") as NSString).replacingCharacters(in: range, with: text)
        self.viewModel.text = newText
//        self.updateViewModel()
        
        return true
    }
}
