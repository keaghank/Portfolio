//
//  DailyViewController.swift
//  Challenger
//
//  Created by Keaghan Knight on 2021/10/31.
//  Copyright © 2021 Keaghan Knight. All rights reserved.
//

import Foundation
import UIKit

class DailyViewController: UITableViewController {
    
    //@IBOutlet weak var MonthDayYear: UILabel!
    
    @IBOutlet weak var table: UITableView?
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let lTrackerModel = lAppDelegate.myTrackerModel
        
        let selectedDay = lTrackerModel.getSelectedDate()
        return lTrackerModel.calendarDictionary[selectedDay]?.count ?? 0
     }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let lTrackerModel = lAppDelegate.myTrackerModel
        
        //let set = lTrackerModel.getSet()
        //let setList = lTrackerModel.getSetList()
        let selectedDay = lTrackerModel.getSelectedDate()
        print(String(selectedDay))
        let dailyLog = lTrackerModel.calendarDictionary[selectedDay]
        print(dailyLog)
        
        //lTrackerModel.currNumRows = lTrackerModel.calendarDictionary[selectedDay]?.count ?? 0
        let currCell = tableView.dequeueReusableCell(withIdentifier: "currDayCell", for: indexPath)
        currCell.textLabel?.text = dailyLog?[indexPath.row]
        
        return currCell
    }
    
    //Function to display selected date as header
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let lTrackerModel = lAppDelegate.myTrackerModel
        
        //lTrackerModel.setSelectedDate(day: lTrackerModel.currDay)
        if(lTrackerModel.daySelected == true){
            return lTrackerModel.getSelectedDate()
            /*
            let currentDateTime = Date()
            lTrackerModel.setMonthYear(label: CalendarHelper().monthString(date: currentDateTime) + " " + CalendarHelper().yearString(date: currentDateTime))
            lTrackerModel.setSelectedDate(day: CalendarHelper().dayString(date: currentDateTime))
            return lTrackerModel.getSelectedDate()
            */
        } else {
            return ""
        }
    }
    
    override func viewDidLoad() {
        //self.tableView?.reloadData()
        super.viewDidLoad()
        
        /*
        let currentDateTime = Date()
        let MonthDayYear = CalendarHelper().monthString(date: currentDateTime) + " " + CalendarHelper().dayString(date: currentDateTime) + ", " + CalendarHelper().yearString(date: currentDateTime)
        // Do any additional setup after loading the view.
        let currentDateTime = Date()
        MonthDayYear.text = CalendarHelper().monthString(date: currentDateTime) + " " + CalendarHelper().dayString(date: currentDateTime) + ", " + CalendarHelper().yearString(date: currentDateTime)
        
        self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "logEntry")
        tableView?.delegate = self
        tableView?.dataSource = self
        */
    }

}
