//
//  LogViewController.swift
//  Challenger
//
//  Created by Keaghan Knight on 2021/10/30.
//  Copyright © 2021 Keaghan Knight. All rights reserved.
//

import Foundation
import UIKit

class LogViewController: UITableViewController {
    
    @IBOutlet var table: UITableView?
    
    //The number of rows is equal to the length of the step and pace history
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let mAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let myModel = mAppDelegate.myTrackerModel
        return myModel.currNumRows
    }
    
    //For each step and pace, create an entry in the list
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let myModel = mAppDelegate.myTrackerModel
        
        let currentDateTime = Date()
        self.title = CalendarHelper().monthString(date: currentDateTime) + " " + CalendarHelper().dayString(date: currentDateTime) + ", " + CalendarHelper().yearString(date: currentDateTime)
        
        let currCell = tableView.dequeueReusableCell(withIdentifier: "logEntry", for: indexPath as IndexPath)
        let item = myModel.getSet() //+ " " + String(rep) + " " + String(weight)
        currCell.textLabel?.text = item
        return currCell
    }
    
    //Load the history view
    override func viewDidLoad() {
        self.table?.reloadData()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}
