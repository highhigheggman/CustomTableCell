//
//  TableViewController.swift
//  CustomTableCell
//
//  Created by yoshiki-t on 2018/08/11.
//  Copyright © 2018年 yoshiki-t. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var Table: UITableView!
    @IBOutlet weak var navigation: UINavigationBar!
    @IBOutlet weak var addButton: UINavigationItem!
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        let controller = UIAlertController(title: "Name",
                                           message: nil,
                                           preferredStyle: .alert)
        
        // OK Button
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler:{
            (action: UIAlertAction!) -> Void in
            let textFields:Array<UITextField>? =  controller.textFields as Array<UITextField>?
            
            if textFields != nil {
                for textField:UITextField in textFields! {
                    self.data.append(textField.text!)
                }
            }
            
        })
        
        // Cancel Button
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel, handler:{
            (action: UIAlertAction!) -> Void in
        })
        
        // add Button Action
        controller.addAction(cancelAction)
        controller.addAction(defaultAction)
        
        // add textfiled
        controller.addTextField(configurationHandler: {(text:UITextField!) -> Void in
        })
        
        // Display Alert
        self.present(controller, animated: true, completion: nil)
    }
    
    var data = ["Taro", "Jiro", "Saburo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableView
        Table.dataSource = self
        Table.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    // return cell height (px)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        cell.label.text = data[indexPath.row]

        return cell
    }
    
    // cell tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // deselect
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
