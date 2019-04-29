//
//  SelectionTableViewController.swift
//  Swift-Utils
//
//  Created by Natalia Martin on 1/6/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import UIKit

protocol SelectionTableViewControllerDelegate: class {
    func selectionTableViewController(_: SelectionTableViewController, didSelecItemAt index: Int, forControl control: UITextField!)
    func selectionTableViewController(_: SelectionTableViewController, didSelectItemsAt indexes: [Int])
}

class SelectionTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var selectionTable: UITableView!
    @IBOutlet weak var applyBtn: UIButton!
    var delegate: SelectionTableViewControllerDelegate?
    var selectedIndex: Int?
    var selectedIndexes = [Int]()
    var items: [String]?
    var dictionaryItems: [[String : String]]?
    var control: UITextField!
    var isMultipleSelection = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectionTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.selectionTable.delegate = self
        self.selectionTable.dataSource = self
        self.selectionTable.allowsMultipleSelection = isMultipleSelection
        self.applyBtn.isHidden = !isMultipleSelection
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isMultipleSelection {
            self.delegate?.selectionTableViewController(self, didSelecItemAt: indexPath.row, forControl: control)
            self.selectedIndex = indexPath.row
            self.dismiss(animated: true, completion: nil)
        } else {
            if self.selectedIndexes.contains(indexPath.row) {
                self.selectedIndexes.remove(at: self.selectedIndexes.firstIndex(of: indexPath.row)!)
            } else {
                self.selectedIndexes.append(indexPath.row)
            }
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell?
        if (!isMultipleSelection && self.selectedIndex == indexPath.row) ||
            (isMultipleSelection && self.selectedIndexes.contains(indexPath.row)){
            cell?.accessoryType = .checkmark
        } else {
            cell?.accessoryType = .none
        }
        
        if self.items != nil {
            cell?.textLabel?.text = self.items![indexPath.row]
        } else {
            cell?.textLabel?.text = self.dictionaryItems![indexPath.row]["name"] ?? ""
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? dictionaryItems?.count ?? 0
    }
    
    @IBAction func applyChanges(_ : Any) {
        delegate?.selectionTableViewController(self, didSelectItemsAt: selectedIndexes)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goBack(_ : Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
