//
//  SecondViewController.swift
//  Challenger
//
//  Created by Keaghan Knight on 2021/10/19.
//  Copyright © 2021 Keaghan Knight. All rights reserved.
//
import Foundation
import UIKit

class DailyLogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //@IBOutlet weak var MonthDayYear: UILabel!
    
    @IBOutlet weak var tableView: UITableView?
    
    //Number of rows of the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let lTrackerModel = lAppDelegate.myTrackerModel
        
        let selectedDay = lTrackerModel.getSelectedDate()
        return lTrackerModel.calendarDictionary[selectedDay]?.count ?? 0
    }
    
    //Build the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let lTrackerModel = lAppDelegate.myTrackerModel
        /*
        let setList = lTrackerModel.getSetList()
        
        let currCell = tableView.dequeueReusableCell(withIdentifier: "logEntry", for: indexPath)
        currCell.textLabel?.text = setList[indexPath.row]
        return currCell
        */
        
        let selectedDay = lTrackerModel.getSelectedDate()
        //print(String(selectedDay))
        let dailyLog = lTrackerModel.calendarDictionary[selectedDay]
        
        //lTrackerModel.currNumRows = lTrackerModel.calendarDictionary[selectedDay]?.count ?? 0
        let currCell = tableView.dequeueReusableCell(withIdentifier: "logEntry", for: indexPath)
        currCell.textLabel?.text = dailyLog?[indexPath.row] //.reversed()
        
        return currCell
    }
    
    //Set the header to the current date
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let lTrackerModel = lAppDelegate.myTrackerModel
        
        /*
        let currentDateTime = Date()
        lTrackerModel.setCurrMonthYear(day: CalendarHelper().monthString(date: currentDateTime) + " " + CalendarHelper().yearString(date: currentDateTime))
        lTrackerModel.setCurrDate(day: CalendarHelper().dayString(date: currentDateTime))
        return lTrackerModel.getCurrDate()
        */
        print(lTrackerModel.currDay)
        if(lTrackerModel.daySelected == true && lTrackerModel.selectedDay != "") {
            return lTrackerModel.getSelectedDate()
        } else {
            return "Select a date from the calendar!"
        }
    }
    
    //Set the user selected entry
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let lTrackerModel = lAppDelegate.myTrackerModel
        
        let selectedDay = lTrackerModel.getSelectedDate()
        let dailyLog = lTrackerModel.calendarDictionary[selectedDay]
        
        lTrackerModel.selectedLogEntry = dailyLog?[indexPath.row] ?? ""
    }
    
    //Reload the table view. Called from first view controller after adding a set
    func reload() {
        tableView?.reloadData()
    }
    
    //When the user is done viewing the log, reload the calendar
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        performSegue(withIdentifier: "unwindToCalendar", sender: self)
    }
    
    //Button to delete selected entry from the log
    @IBAction func removeEntry(_ sender: Any) {
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        var lTrackerModel = lAppDelegate.myTrackerModel
        
        let selectedDay = lTrackerModel.getSelectedDate()
        let selectedToRemove = lTrackerModel.selectedLogEntry
        let index = (lTrackerModel.calendarDictionary[selectedDay]?.firstIndex(of: selectedToRemove))
        if(lTrackerModel.selectedLogEntry != "") {
            lTrackerModel.calendarDictionary[selectedDay]?.remove(at: index!)
        }
        //lTrackerModel.saveDay()
        self.reload()
    }
    
    //Button to save the current log
    @IBAction func saveDictionary(_ sender: Any) {
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let lTrackerModel = lAppDelegate.myTrackerModel
        lTrackerModel.saveDay()
    }
    
    
    //On load
    override func viewDidLoad() {
        //self.tableView?.reloadData()
        super.viewDidLoad()
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
        overrideUserInterfaceStyle = .light
        
        //self.reload()
        
        //let currentDateTime = Date()
        
        // Do any additional setup after loading the view.
        
        /*
        let currentDateTime = Date()
        MonthDayYear.text = CalendarHelper().monthString(date: currentDateTime) + " " + CalendarHelper().dayString(date: currentDateTime) + ", " + CalendarHelper().yearString(date: currentDateTime)
        
        self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "logEntry")
        tableView?.delegate = self
        tableView?.dataSource = self
        */
    }

}

