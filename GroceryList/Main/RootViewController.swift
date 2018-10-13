//
//  RootViewController.swift
//  GroceryList
//
//  Created by Rob Daly on 10/13/18.
//  Copyright © 2018 Rob Daly. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewList))
        // Do any additional setup after loading the view.
    }
    

    @objc func addNewList() {
        performSegue(withIdentifier: "newListSegue", sender: self)
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
