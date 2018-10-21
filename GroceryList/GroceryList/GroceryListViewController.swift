//
//  GroceryListViewController.swift
//  GroceryList
//
//  Created by Rob Daly on 10/20/18.
//  Copyright © 2018 Rob Daly. All rights reserved.
//

import UIKit

class GroceryListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sort the data source here then set it
        // tech debt ahead, will make this more efficient later
        var dataSource: [[GroceryListItem]] = []
        let groceryListItems = (groceryList?.items?.allObjects as! [GroceryListItem])
        var groceryListItemTypes = (groceryListItems.map { return $0.grocery?.type})
        groceryListItemTypes.sort(by: { return $0! < $1! })
        
        groceryListItemTypes.forEach { groceryType in
            let groceries = groceryListItems.filter { groceryType == $0.grocery?.type }
            dataSource.append(groceries)
        }
        
        self.sortedGroceryItems = dataSource
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    var groceryList: GroceryList?
    var sortedGroceryItems: [[GroceryListItem]]?

    @IBOutlet weak var tableView: UITableView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GroceryListViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        print("fdfdf")
//    }
}

extension GroceryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sortedGroceryItems![section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sortedGroceryItems!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "groceryListCell") {
            cell.textLabel?.text = self.sortedGroceryItems![indexPath.section][indexPath.row].itemText
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let type = GroceryType.init(rawValue: Int(self.sortedGroceryItems![section][0].grocery?.type ?? 0))
        return type?.getGroceryTypeName()
    }
}
