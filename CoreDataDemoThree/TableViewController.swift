//
//  ViewController.swift
//  CoreDataDemoThree
//
//  Created by Vu on 5/4/19.
//  Copyright © 2019 Vu. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var data: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchObject()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func fetchObject() {
        if let data = (try? AppDelegate.context.fetch(Entity.fetchRequest()) as [Entity]) {
            self.data = data.map { $0.string ?? ""}
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    // TODO2: Thực hiện hàm add More và Hiển Thị alert
    @IBAction func addMore(_ sender: UIBarButtonItem) {
        showAlert(title: "Add More", message: "Nhập cái bạn muốn lưutại đây") { alert in
            
            // TODO 4: Lấy dữ liệu từ trong textField của Alert
            if let content = alert.textFields?.first?.text {
                // TODO 5: Khởi tạo Entity với context và lưu xuống
                let entity = Entity(context: AppDelegate.context)
                entity.string = content
                AppDelegate.saveContext()
                // TODO 6: Thực hiện fetch lại dữ liệu và hiển thị lên trên TableView
                self.fetchObject()
                
            }
        }
    }
    
}

// TODO 3: Show Alert
func showAlert(title: String, message: String, completHandler: ((UIAlertController) -> Void)? = nil) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addTextField { textField in
        textField.placeholder = "Write here!!!"
    }
    let okAction = UIAlertAction(title: "OK", style: .cancel) { (result: UIAlertAction) -> Void in
        completHandler?(alertController)
    }
    alertController.addAction(okAction)
    
    if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
        rootVC.present(alertController, animated: true, completion: nil)
    }
    
}
