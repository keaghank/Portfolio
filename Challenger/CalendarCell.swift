//
//  CalendarCell.swift
//  Challenger
//
//  Created by Keaghan Knight on 2021/10/29.
//  Copyright © 2021 Keaghan Knight. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var cellImage: UIImageView!
    
    //Animate selected cells and update the model
    override var isSelected: Bool {
        didSet{
            let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
            let lTrackerModel = lAppDelegate.myTrackerModel
                if self.isSelected {
                    if(self.dayLabel.textColor == UIColor.black) {
                        UIView.animate(withDuration: 0.3) { // for animation effect
                            self.dayLabel.textColor = UIColor.red
                            //self.cellImage.image = UIImage(named: "weight")
                            lTrackerModel.daySelected = true
                            lTrackerModel.setSelectedDate(day: self.dayLabel.text ?? "")
                            lTrackerModel.currDay = self.dayLabel.text!
                             //self.backgroundColor = UIColor(red: 115/255, green: 190/255, blue: 170/255, alpha: 1.0)
                            
                        }
                    }
                    /*
                    else if(self.dayLabel.textColor == UIColor.red) {
                        UIView.animate(withDuration: 0.3) { // for animation effect
                            lTrackerModel.daySelected = false
                            self.dayLabel.textColor = UIColor.black
                        }
                    }
                    */
                }
                else {
                    UIView.animate(withDuration: 0.3) { // for animation effect
                        self.dayLabel.textColor = UIColor.black
                        // self.backgroundColor = UIColor(red: 60/255, green: 63/255, blue: 73/255, alpha: 1.0)
                    }
                }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cellImage.isHidden = true
    }
    
    /*
    override func didMoveToWindow() {
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let lTrackerModel = lAppDelegate.myTrackerModel
        
        let selectedDay = lTrackerModel.getSelectedDate()
        //let log = lTrackerModel.calendarDictionary[selectedDay]
         
        //print(log)
        if(lTrackerModel.calendarDictionary[selectedDay] != nil) {
            self.cellImage.image = UIImage(named: "weight")
        }
    }
    */

}
