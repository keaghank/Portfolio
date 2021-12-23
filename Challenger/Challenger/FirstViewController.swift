//
//  FirstViewController.swift
//  Challenger
//
//  Created by Keaghan Knight on 2021/10/19.
//  Copyright © 2021 Keaghan Knight. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var exerciseInput: UITextField!
    @IBOutlet weak var repInput: UITextField!
    @IBOutlet weak var weightInput: UITextField!
    
    let currentDateTime = Date()
    
    //var set: String = ""
    
    @IBAction func clearButton(_ sender: Any) {
        exerciseInput.text = ""
        repInput.text = ""
        weightInput.text = ""
        
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let lTrackerModel = lAppDelegate.myTrackerModel
        
        lTrackerModel.reSet()
    
    }
    
    //Add to the daily log. Right now if the user selects a date and then adds a set, it sets the header to the selected date. Should be fixed to current date
    @IBAction func addButton(_ sender: UIButton) {
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let lTrackerModel = lAppDelegate.myTrackerModel
        
        lTrackerModel.strSet = exerciseInput.text ?? ""
        lTrackerModel.currRep = repInput.text ?? ""
        lTrackerModel.currWeight = weightInput.text ?? ""
        
        lTrackerModel.addEntry()
        
        if let tabBarController = self.tabBarController {
            if let siblingViewControllers = tabBarController.viewControllers {
                let tableViewController = siblingViewControllers[1]
                let tableViewDelegate = tableViewController as! SecondViewController
                tableViewDelegate.reload()
            }
        }
        
        /*
        let tabBarController = self.tabBarController
        let siblingViewControllers = tabBarController?.viewControllers
        let logViewController = siblingViewControllers?[1] as? UIViewController
        let logDataSource = logViewController?.children[0] as? UITableViewDataSource
         */
        
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mySeque" {
            let vc = segue.destination as! LogViewController
            vc.title = CalendarHelper().monthString(date: currentDateTime) + " " + CalendarHelper().dayString(date: currentDateTime) + ", " + CalendarHelper().yearString(date: currentDateTime)
            
        }
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
    }


}

