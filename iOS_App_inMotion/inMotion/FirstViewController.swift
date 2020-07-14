//
//  FirstViewController.swift
//  inMotion
//
//  Created by Guest, Abbie Colleen on 4/28/20.
//  Copyright © 2020 C323 / Spring 2020. All rights reserved.

//Abbie Guest: abguest@iu.edu
//Jacob Ringer: jwringer@iu.edu
//Keaghan Knight: ktknight@iu.edu
//inMotion
//Submission date May 7, 2020//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate {

    //Labels used for the view
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var nameHolder: UILabel!
    
    //Update the model when the user creates a name
    @IBAction func pressedEnter(_ sender: UIButton) {
        welcomeLabel.text = "Welcome," + "\n"
        nameHolder.text = String(nameInput.text!) + "!"
        
        let lAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let lMotionModel = lAppDelegate.motionModel
        //Changes name
        lMotionModel.userName = nameInput.text ?? ""
        nameInput.text = ""
        //Starts session
        lMotionModel.sessionStarted = true
    }
    
    //Dismiss the keyboard when the user is done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    //Load the view
    //Create a UITextField Delegate for the username
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.nameInput.delegate = self
    }
    
    //Send the given username to the activity screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mySegue" {
            let vc = segue.destination as! SecondViewController
            vc.nameText = nameInput.text ?? ""
        }
    }
    


}

