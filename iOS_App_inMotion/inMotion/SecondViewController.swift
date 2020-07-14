//
//  SecondViewController.swift
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


import UIKit
import CoreMotion

class SecondViewController: UIViewController {
    
    var nameText = ""
    var stopWatch = Timer()
    
    //Name, step, and pace label
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var velocityLabel: UILabel!
    
    
    //Load the view
    override func viewDidLoad() {
        super.viewDidLoad()

        //Gets model and delegate and starts time interval
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let lMotionModel = lAppDelegate.motionModel
        
        self.nameLabel.text = nameText
        
    }
    
    //When the view loads check if a name is present or not
    //If not assign Hello! otherwise assign the given name
    override func viewDidAppear(_ animated: Bool){
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let lMotionModel = lAppDelegate.motionModel
        if(lMotionModel.userName == "") {
            self.nameLabel.text = "Hello!"
        } else {
            self.nameLabel.text = lMotionModel.userName + ","
        }
    }
    
    //Update the labels for steps and pace
    @objc func updateLabels(){
        //function to update labels to model variables
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let lMotionModel = lAppDelegate.motionModel
        let stepString: String? = String(lMotionModel.updateSteps())
        let velocityString: String? = String(lMotionModel.updatePace())
        self.stepLabel.text = stepString
        self.velocityLabel.text = velocityString
    }

    func TimerInterval(){
        //Every half second, runs update labels function
        stopWatch = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.updateLabels), userInfo: nil, repeats: true)
    }

    //Button to start a model session
    //Begins tracking steps and pace
    @IBAction func startButton(_ sender: UIButton) {
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let lMotionModel = lAppDelegate.motionModel
        lMotionModel.sessionStarted = true
        TimerInterval()
    }
    
    //Button to stop a model session
    //End tracking of steps and pace
    //Send the previous session to the history view
    @IBAction func stopButton(_ sender: UIButton) {
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let lMotionModel = lAppDelegate.motionModel
        if(lMotionModel.sessionStarted == true) {
            lMotionModel.sessionStarted = false
            lMotionModel.historyRowCounter += 1
            lMotionModel.addHistory()
            stopWatch.invalidate()
            if let tabBarController = self.tabBarController {
                if let siblingViewControllers = tabBarController.viewControllers {
                    if let tableViewController = siblingViewControllers[2] as? UITableViewController {
                        if let tableView = tableViewController.view as? UITableView {
                            tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    //Button to reset the steps and pace values in both
    //the model and the view
    @IBAction func resetButton(_ sender: UIButton) {
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let lMotionModel = lAppDelegate.motionModel
        lMotionModel.sessionStarted = false
        lMotionModel.numSteps = 0
        lMotionModel.avgPace = 0.0
        self.stepLabel.text = "0"
        self.velocityLabel.text = "0.0"
        
    }
}

