//
//  GameVC.swift
//  cse335f18_lab08-archer_patrick
//
//  Created by Patrick Archer on 11/21/18.
//  Copyright © 2018 Patrick Archer - Self. All rights reserved.
//

import UIKit

class GameVC: UIViewController {
    
    var timer : Timer?
    var counter  = 0
    var timeRemaining:Int = 10

    //=============================================//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // enable monkey nav buttons
        enableButtons()
        
        // set initial text of time remaining bar button/text
        self.barButton_timeRemaining.title = "Time Left: \(String(timeRemaining))"
        
        // set values for monkey and banana images
        self.image_monkey.image = UIImage(named: "appleMonkey.jpeg")
        self.image_banana.image = UIImage(named: "banana.jpg")
        
        // initialize timer
        timer = Timer();
        startTimer()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //=============================================//

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        print("\nPreparing for segue from GameVC.\n") // debug
    }
    
    //=============================================//
    
    @IBOutlet weak var barButton_timeRemaining: UIBarButtonItem!
    @IBOutlet weak var image_monkey: UIImageView!
    @IBOutlet weak var image_banana: UIImageView!
    
    @IBAction func barButton_back(_ sender: UIBarButtonItem) {
        timer?.invalidate()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func barButton_timePressed(_ sender: UIBarButtonItem) {
        print("\nNOTE: Pressing the timer button does nothing :)\n") // debug
    }
    
    
    @IBOutlet weak var buttonOutlet_up: UIButton!
    @IBAction func button_up(_ sender: UIButton) {
        var frame  = self.image_monkey.frame
        frame.origin.y -= 10
        self.image_monkey.frame =  frame
        
        checkIfIntersect()
    }
    
    @IBOutlet weak var buttonOutlet_down: UIButton!
    @IBAction func button_down(_ sender: UIButton) {
        var frame  = self.image_monkey.frame
        frame.origin.y += 10
        self.image_monkey.frame =  frame
        
        checkIfIntersect()
    }
    
    @IBOutlet weak var buttonOutlet_right: UIButton!
    @IBAction func button_right(_ sender: UIButton) {
        var frame  = self.image_monkey.frame
        frame.origin.x += 10
        self.image_monkey.frame =  frame
        
        checkIfIntersect()
    }
    
    @IBOutlet weak var buttonOutlet_left: UIButton!
    @IBAction func button_left(_ sender: UIButton) {
        var frame  = self.image_monkey.frame
        frame.origin.x -= 10
        self.image_monkey.frame =  frame
        
        checkIfIntersect()
    }
    
    func startTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameVC.count), userInfo: nil, repeats: true)
    }
    
    @objc func count()
    {
        counter = counter + 1
        timeRemaining = timeRemaining - 1
        self.barButton_timeRemaining.title = "Time Left: \(String(timeRemaining))"
        
        if (timeRemaining <= 0)
        {
            timer?.invalidate()
            displayLoseAlert()
            disableButtons()
            
        }
    }
    
    func checkIfIntersect()
    {
        if(viewIntersectsView(image_monkey, second_View: image_banana))
        {
            self.image_banana.isHidden = true
            timer?.invalidate()
            
            displayWinAlert()
            disableButtons()
        }
    }
    
    /*func checkTimeRemaining() -> Bool
    {
        if (timeRemaining >= 1)
        {
            return true
        }
        else
        {
            timer?.invalidate()
            return false
        }
    }*/
    
    func displayWinAlert()
    {
        let alertMsg = "Congrats! You have won! To play again, press the BACK button then, once you are ready, press the START button and a new game will begin."
        
        let alert = UIAlertController(title: "You Won!", message: alertMsg, preferredStyle: .alert)
        
        // handles what to do when user presses the CANCEL button in the alert
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func displayLoseAlert()
    {
        let alertMsg = "You ran out of time! Better luck next game. To play again, press the BACK button then, once you are ready, press the START button and a new game will begin."
        
        let alert = UIAlertController(title: "You Lost!", message: alertMsg, preferredStyle: .alert)
        
        // handles what to do when user presses the CANCEL button in the alert
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func disableButtons()
    {
        self.buttonOutlet_up.isEnabled = false
        self.buttonOutlet_down.isEnabled = false
        self.buttonOutlet_left.isEnabled = false
        self.buttonOutlet_right.isEnabled = false
    }
    
    func enableButtons()
    {
        self.buttonOutlet_up.isEnabled = true
        self.buttonOutlet_down.isEnabled = true
        self.buttonOutlet_left.isEnabled = true
        self.buttonOutlet_right.isEnabled = true
    }
    
    //=============================================//
    
    func viewIntersectsView(_ first_View: UIView, second_View:UIView) -> Bool
    {
        return first_View.frame.intersects(second_View.frame)
    }

}
