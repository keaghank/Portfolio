//
//  ProgressViewController.swift
//  Challenger
//
//  Created by Keaghan Knight on 2021/11/11.
//  Copyright © 2021 Keaghan Knight. All rights reserved.
//

import Foundation
import UIKit

//Future view to track progress
class ProgressViewController: UIViewController {
    
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var selectExercise: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let lTrackerModel = lAppDelegate.myTrackerModel
        
        if(lTrackerModel.selectedDay != "") {
            dayLabel.text = lTrackerModel.selectedDay
        } else {
            dayLabel.text = "Select a day!"
        }
        
    }
}
