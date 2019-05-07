//
//  TableViewController1.swift
//  CoreDataDemoThree
//
//  Created by Vu on 5/6/19.
//  Copyright © 2019 Vu. All rights reserved.
//

import UIKit

class TableViewController1: UITableViewController {
    var data: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchObject()
    }
    func fetchObject() {
        if let  data = try? AppDelegate.context.fetch(Entity.fetchRequest()) as [Entity] {
            self.data = data.map { $0.string ?? ""}
        }
        self.tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    @IBAction func addMore1(_ sender: UIBarButtonItem) {
        showAlert1(title: "Add More", message: "Do Something") { alert in
            if let content = alert.textFields?.first?.text {
                var entity = Entity(context: AppDelegate.context)
                    entity.string = content
                AppDelegate.saveContext()
                self.fetchObject()
            }
        }
    }
    
}

func showAlert1(title: String, message: String, compleHander: ((UIAlertController) -> Void)? = nil) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addTextField { textField in
        textField.placeholder = "Write Here!!"
    }
    let okAction = UIAlertAction(title: "Ok", style: .cancel) { (result: UIAlertAction) in
        compleHander?(alertController)
    }
    alertController.addAction(okAction)
    if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
        rootVC.present(alertController, animated: true, completion: nil)
    }
    
}
