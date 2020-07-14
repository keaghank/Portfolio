//
//  inMotionModel.swift
//  inMotion
//
//  Created by Anaise McCrovitz on 5/1/20.
//  Copyright © 2020 C323 / Spring 2020. All rights reserved.
// Team Gamboge
//Abbie Guest: abguest@iu.edu
//Jacob Ringer: jwringer@iu.edu
//Keaghan Knight: ktknight@iu.edu
//inMotion
//Submission date May 7, 2020

import Foundation
import CoreMotion

class inMotionModel {

    var userName = ""
    var numSteps = 0
    var avgPace = 0.0
    var sessionStarted = false
    let pedometerData = CMPedometerData()
    let pedoMeter = CMPedometer()
    let date = Date()
    var manager = CMMotionManager()
    var historyRowCounter = 0
    
    var stepHistory : [Int] = []
    var paceHistory : [Double] = []
    
    //Return the history of the number of steps
    func getSteps() -> [Int] {
        return self.stepHistory
    }
    
    //Return the history of the average pace
    func getPace() -> [Double] {
        return self.paceHistory
    }
    
    //Return the current number of steps as an integer using the pedometer
    func updateSteps() -> Int {
        //Retrieve steps from package
        if (sessionStarted) {
            if (CMPedometer.isStepCountingAvailable()) {
                self.pedoMeter.startUpdates(from: date) { (data: CMPedometerData?, error) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    if(error == nil){
                        //print("\(data!.numberOfSteps)")
                        self.numSteps = data?.numberOfSteps as! Int
                        //print(self.numSteps)
                    }
                })
                }
                
                return numSteps
            }
        }
        if (!sessionStarted) {
            pedoMeter.stopUpdates()
        }
        return self.numSteps
    }
    
    //Return the average pace as a double using the pedometer data
    func updatePace() -> Double {
        //Retrieve volocity from package
        if (sessionStarted) {
            if(CMPedometer.isPaceAvailable()) {
                self.pedoMeter.startUpdates(from: date) { (data: CMPedometerData?, error) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    if(error == nil){
                        //print("\(data!.averageActivePace)")
                        let currPace = data?.averageActivePace as! Double
                        let truncPace = Double(String(format: "%.1f", (currPace * 100)).dropLast(2))!/100
                        self.avgPace = truncPace
                    }
                })
                }
                return self.avgPace
            }
        }
        if(!sessionStarted){
            self.pedoMeter.stopUpdates()
        }
        return self.avgPace
    }
    
    
    //Function to add the given session to a list in the
    //history view controller
    func addHistory() {
        self.stepHistory.append(self.numSteps)
        print(stepHistory)
        self.paceHistory.append(self.avgPace)
        print(paceHistory)
        print(self.historyRowCounter)
    }
    
}
