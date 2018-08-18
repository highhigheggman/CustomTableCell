//
//  TableViewController.swift
//  CustomTableCell
//
//  Created by yoshiki-t on 2018/08/11.
//  Copyright © 2018年 yoshiki-t. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var cellHeight = 100.0
    var cellClose = [Int]()
    
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
                    print(self.data.count - 1)
                    self.cellClose.append(self.data.count - 1)
                    self.Table.insertRows(at: [IndexPath(row: self.data.count - 1, section: 0)], with: .left)
                    let theCell = self.Table.cellForRow(at: IndexPath(row: self.data.count - 1, section: 0)) as! CustomCell
                    
                    // Animation color : initial val = blue
                    theCell.backgroundColor = UIColor.blue
                    
                    // Animation color : initial val = blue
                    theCell.backgroundColor = UIColor.blue
                    
                    UIView.animate(withDuration: 1.5, delay: 0.0, options: [], animations: {
                        self.Table.beginUpdates()
                        self.cellClose.remove(at: self.cellClose.index(of: self.data.count - 1)!)
                        self.Table.endUpdates()
                        theCell.layoutIfNeeded()
                        
                    }, completion: { _ in
                        UIView.animate(withDuration: 2.5, delay: 1.0, options: [], animations: {
                            theCell.backgroundColor = UIColor.white
                            
                        }, completion: nil)
                    })
                    
                    
                    /*
                     UIView.animateKeyframes(withDuration: 3.0, delay: 0, options: [], animations: {
                     
                     UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                     self.Table.beginUpdates()
                     self.cellClose.remove(at: self.cellClose.index(of: self.data.count - 1)!)
                     self.Table.endUpdates()
                     theCell.layoutIfNeeded()
                     })
                     
                     
                     UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                     theCell.backgroundColor = UIColor.white
                     })
                     
                     
                     }, completion: nil)*/
                    
                    
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
    
    var data = ["AAAA", "BBBB", "CCCC"]
    
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
        if (self.cellClose.contains(indexPath.row)) {
            return 0
        } else {
            return 100
        }
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
