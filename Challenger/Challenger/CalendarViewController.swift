//
//  ThirdVeiwController.swift
//  Challenger
//
//  Created by Keaghan Knight on 2021/10/21.
//  Copyright © 2021 Keaghan Knight. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var selectedDayLabel: UILabel!
    
    @IBOutlet weak var calendarCollection: UICollectionView!
    
    @IBOutlet weak var inputExercise: UITextField!
    @IBOutlet weak var inputReps: UITextField!
    @IBOutlet weak var inputWeight: UITextField!
    
    @IBOutlet weak var repsStepper: UIStepper!
    @IBOutlet weak var weightStepper: UIStepper!
    
    var selectedDate = Date()
    var totalSquares = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let lTrackerModel = lAppDelegate.myTrackerModel
        
        let tempDict = lTrackerModel.userDefaults.object(forKey: "myCalendar")
        if(tempDict != nil) {
            lTrackerModel.calendarDictionary = tempDict as! [String : [String]]
        }
        
        setCellsView()
        setMonthView()
        
        lTrackerModel.setMonthYear(label: self.monthLabel.text!)
        
        self.inputExercise.delegate = self
        
        selectedDayLabel.text = "Select a day!"
        
        repsStepper.autorepeat = true
        repsStepper.minimumValue = 0
        
        weightStepper.autorepeat = true
        weightStepper.minimumValue = 0
        
        overrideUserInterfaceStyle = .light
        
        
        //let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        //view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
        /*
        calendarCollection.dataSource = self
        extension CalendarViewController: UICollectionViewDataSource {
            func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "com.codepath.DayCell", for: <#T##IndexPath#>) as! CalendarCell
                
            }
        }
         */
        
    }
    
    //Create cells for days
    func setCellsView()
    {
        let width = (calendarCollection.frame.size.width - 2) / 8
        let height = (calendarCollection.frame.size.height - 2) / 7
        
        let flowLayout = calendarCollection.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    //Create the month
    func setMonthView()
    {
        totalSquares.removeAll()
        
        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
        
        var count: Int = 1
        
        while(count <= 42)
        {
            if(count <= startingSpaces || count - startingSpaces > daysInMonth)
            {
                totalSquares.append("")
            }
            else
            {
                totalSquares.append(String(count - startingSpaces))
            }
            count += 1
        }
        
        monthLabel.text = CalendarHelper().monthString(date: selectedDate)
            + " " + CalendarHelper().yearString(date: selectedDate)
        calendarCollection.reloadData()
    }
    
    //Total cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    //Populate the cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "com.codepath.CalendarCell", for: indexPath) as! CalendarCell
        
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let lTrackerModel = lAppDelegate.myTrackerModel
        
        cell.dayLabel.text = totalSquares[indexPath.item]
        
        var currDate = ""
        let cellDay = cell.dayLabel.text
        if(cellDay!.count < 2) {
            currDate = "0" + cellDay!
            currDate += " " + lTrackerModel.selectedMonthYear
        } else {
            currDate = cellDay!
            currDate += " " + lTrackerModel.selectedMonthYear
        }
        
        let selectedDay = lTrackerModel.getSelectedDate()
        
        //print(lTrackerModel.selectedDay)
        //print(currDate)
        //print(lTrackerModel.calendarDictionary[currDate])
        //lTrackerModel.calendarDictionary[selectedDay] != nil && lTrackerModel.selectedDay == currDate
        if(lTrackerModel.calendarDictionary[currDate] != nil && lTrackerModel.calendarDictionary[currDate] != []) {
            cell.cellImage.image = UIImage(named: "weight")
            cell.cellImage.isHidden = false
        }
        
        if(selectedDay == currDate) {
            cell.dayLabel.textColor = UIColor.red
        }
        
        return cell
    }
    
    //When a cell is selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let lTrackerModel = lAppDelegate.myTrackerModel
        
        calendarCollection.reloadData()
        if(lTrackerModel.selectedDay == "") {
            selectedDayLabel.text = "Select a day!"
        } else {
            selectedDayLabel.text = lTrackerModel.selectedDay
        }
    }
    
    //When the user selects a day, open the daily log
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let lTrackerModel = lAppDelegate.myTrackerModel
        if(identifier == "viewLog") {
            if(lTrackerModel.selectedDay == "") {
                return false
            } else {
                return true
            }
        }
        return true
    }
    
    //When the user is done looking at daily log, reload calendar
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        calendarCollection.reloadData()
    }
    
    //Button for last month
    @IBAction func previousMonth(_ sender: Any)
    {
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let lTrackerModel = lAppDelegate.myTrackerModel
        
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        setMonthView()
        
        lTrackerModel.setMonthYear(label: monthLabel.text!)
    }
    
    //Button for next month
    @IBAction func nextMonth(_ sender: Any)
    {
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let lTrackerModel = lAppDelegate.myTrackerModel
        
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
        
        lTrackerModel.setMonthYear(label: monthLabel.text!)
    }
    
    //Button for rep tracker
    @IBAction func adjustReps(_ sender: UIStepper) {
        inputReps.text = Int(sender.value).description
    }
    
    //Button for weight tracker
    @IBAction func adjustWeight(_ sender: UIStepper) {
        inputWeight.text = Int(sender.value).description
    }
    
    //Button to send set set to log view
    @IBAction func addSet(_ sender: Any) {
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let lTrackerModel = lAppDelegate.myTrackerModel
        
        if(inputExercise.text != "") {
            lTrackerModel.currExercise = inputExercise.text ?? ""
            lTrackerModel.currRep = Int(inputReps.text!) ?? 0
            lTrackerModel.currWeight = Int(inputWeight.text!) ?? 0
        
            lTrackerModel.addEntry()
            calendarCollection.reloadData()
        }
    }
    
    //Button to clear user input
    @IBAction func clearSet(_ sender: Any) {
        inputExercise.text = ""
        inputReps.text = "0"
        inputWeight.text = "0"
        
        repsStepper.value = 0
        weightStepper.value = 0
        
        //let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        //let lTrackerModel = lAppDelegate.myTrackerModel
        
        //lTrackerModel.reSet()
    }
    
    //Dismiss the keyboard
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override open var shouldAutorotate: Bool
    {
        return false
    }
}
