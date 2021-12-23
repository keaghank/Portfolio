//
//  trackerModel.swift
//  Challenger
//
//  Created by Keaghan Knight on 2021/10/30.
//  Copyright © 2021 Keaghan Knight. All rights reserved.
//

import Foundation
import CoreMotion

class trackerModel {
    
    let userDefaults = UserDefaults.standard
    
    var numSet = 0
    var strSet = ""
    var currExercise = ""
    var currRep = 0
    var currWeight = 0
    var currNumRows = 0
    
    //Store a log of exercises as a list of strings
    var setList = [String]()
    var calendarDictionary = [String: [String]]()
    var exerciseDictionary = [String: [Int]]()

    var currDay = ""
    var currMonthYear = ""
    var selectedDay = ""
    var selectedMonthYear = ""
    var selectedLogEntry = ""
    
    var daySelected = false
    var editingExercise = false
    
    //Return the most recently entered exercise
    func getSet() -> String {
        return self.strSet
    }
    
    //Return the exercise log
    func getSetList() -> [String] {
        return self.setList
    }
    
    //Add user input to log when button pressed
    func addEntry() {
        if(selectedDay != "") {
            //self.currNumRows+=1
            setList = []
            strSet = currExercise
            if(currRep != 0 && currRep != nil && currWeight != 0 && currWeight != nil) {
                strSet.append(" Reps:" + String(currRep) + " Weight:" + String(currWeight))
                setList.append(strSet)
                //setList.insert(strSet, at:0)
            } else {
                setList.append(strSet)
                //setList.insert(strSet, at:0)
            }
            
            /*
            if(calendarDictionary.isEmpty) {
                calendarDictionary[selectedDay] = setList
            } else if(calendarDictionary[selectedDay] != nil){
                    calendarDictionary.updateValue(setList, forKey: selectedDay)
            }
             */
            
            if(calendarDictionary[selectedDay] != nil) {
                let tempSetList = calendarDictionary[selectedDay]
                for i in tempSetList ?? []{
                    setList.append(i)
                    //setList.insert(i, at:0)
                }
                calendarDictionary[selectedDay] = setList
            } else {
                calendarDictionary[selectedDay] = setList
            }
            //print(setList)
            
            if(exerciseDictionary[currExercise] != nil) {
                var currWeightList = exerciseDictionary[currExercise]
                currWeightList?.append(currWeight)
                exerciseDictionary[currExercise] = currWeightList
            } else {
                exerciseDictionary[currExercise] = [currWeight]
            }
        }
    }
    
    //Save the log to device memory
    func saveDay() {
        /*
        if(calendarDictionary.isEmpty) {
            userDefaults.set(nil, forKey: "myCalendar")
        }
         */
        userDefaults.set(calendarDictionary, forKey: "myCalendar")
    }
    
    //Clear user input when button pressed
    func reSet() {
        self.strSet = ""
        currRep = 0
        currWeight = 0
    }
    
    func setMonthYear(label: String) {
        selectedMonthYear = label
    }
    
    func setCurrMonthYear(day: String) {
        currMonthYear = day
    }
    
    func setSelectedDate(day: String) {
        if(day != "") {
            var newDay = ""
            if(day.count < 2) {
                newDay = "0" + day
            } else {
                newDay = day
            }
            currDay = day
            selectedDay = newDay + " "
            selectedDay.append(selectedMonthYear)
            setList = [String]()
            //currNumRows = 0
        } else {
            selectedDay = ""
        }
    }
    
    func getSelectedDate() -> String {
        return self.selectedDay
    }
    
    func setCurrDate(day: String) {
        currDay = day + " "
        currDay.append(currMonthYear)
    }
    
    func getCurrDate() -> String {
        return self.currDay
    }
    
    func clearSelect() {
        self.daySelected = false
    }
    
}

/*
struct Set {
    var numSet = 0
    var exercise = ""
    var reps = 0
    var weight = 0
}
 */
