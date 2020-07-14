//
//  HistoryViewController.swift
//  inMotion
//
//  Created by Guest, Abbie Colleen on 4/28/20.
//  Copyright © 2020 C323 / Spring 2020. All rights reserved.
//

//Abbie Guest: abguest@iu.edu
//Jacob Ringer: jwringer@iu.edu
//Keaghan Knight: ktknight@iu.edu
//inMotion
//Submission date May 7, 2020


import Foundation
import UIKit

class HistoryViewController: UITableViewController {
    
    @IBOutlet var table: UITableView?
    
    //The number of rows is equal to the length of the step and pace history
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let mAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let myModel = mAppDelegate.motionModel
        return myModel.historyRowCounter
    }
    
    //For each step and pace, create an entry in the list
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let myModel = mAppDelegate.motionModel
        
        let stepH = myModel.getSteps()
        let paceH = myModel.getPace()
        
        let currCell = tableView.dequeueReusableCell(withIdentifier: "myActivity", for: indexPath)
        let item = String(stepH[indexPath.item]) + " steps, at an average pace of " + String(paceH[indexPath.item]) + "m/s"
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
