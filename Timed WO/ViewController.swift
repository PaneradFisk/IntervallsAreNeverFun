//
//  ViewController.swift
//  Timed WO
//
//  Created by André Bergvall on 2020-01-18.
//  Copyright © 2020 André Bergvall. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    
    
    
    var workoutTimer:Timer?
    var restTimer:Timer?
    
    var workoutTimeLeft = 45
    var restTimeLeft = 60
    
    var whichTimer = ""
    var workout = "workoutTimer"
    var rest = "restTimer"
    
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var resumeBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    
    
    @IBOutlet weak var workoutTimeLabel: UILabel!
    @IBOutlet weak var restTimeLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetStartScreen()
        
        startBtn.isHidden = false
        pauseBtn.isHidden = true
        resumeBtn.isHidden = true
        stopBtn.isHidden = true
        
        
        
    }
    
    
    
    @IBAction func startButton(_ sender: Any) {
        resetStartScreen()
        runWorkoutTimer()
        startBtn.isHidden = true
        pauseBtn.isHidden = false
        resumeBtn.isHidden = true
        stopBtn.isHidden = false

        
    }
    @IBAction func pauseButton(_ sender: Any) {
        startBtn.isHidden = true
        pauseBtn.isHidden = true
        resumeBtn.isHidden = false
        stopBtn.isHidden = false
        pauseTimers()

    }
    @IBAction func resumeButton(_ sender: Any) {
        startBtn.isHidden = true
        resumeBtn.isHidden = true
        pauseBtn.isHidden = false
        stopBtn.isHidden = false
        resumeTimers()

    }
    @IBAction func stopButton(_ sender: Any) {
        startBtn.isHidden = false
        pauseBtn.isHidden = true
        resumeBtn.isHidden = true
        stopBtn.isHidden = true
        workoutTimer?.invalidate()
        workoutTimer = nil
        restTimer?.invalidate()
        restTimer = nil
        workoutTimeLeft = 45
        restTimeLeft = 60
        workoutTimeLabel.text = "Workout stopped"
        restTimeLabel.text = "Resetting workout"
    }
    
    func resetStartScreen(){
        workoutTimeLabel.text = "Workout timer set to 45s"
        restTimeLabel.text = "Rest timer set to 60s"
    }
    
    func runWorkoutTimer(){
        workoutTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onWorkoutTimerFires), userInfo: nil, repeats: true)
        whichTimer = workout
    }
    
    @objc func onWorkoutTimerFires(){
        workoutTimeLeft -= 1
        workoutTimeLabel.text = "\(workoutTimeLeft) secounds left of workout"
        
        if workoutTimeLeft <= 0 {
            workoutTimer?.invalidate()
            workoutTimer = nil
            runRestTimer()
            whichTimer = rest
            workoutTimeLeft = 45
        }
    }
    
    func runRestTimer(){
        restTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onRestTimerFires), userInfo: nil, repeats: true)
        whichTimer = rest
    }
    
    @objc func onRestTimerFires(){
        restTimeLeft -= 1
        restTimeLabel.text = "\(restTimeLeft) secounds left of rest period"
        
        if restTimeLeft <= 0 {
            restTimer?.invalidate()
            restTimer = nil
            runWorkoutTimer()
            whichTimer = workout
            restTimeLeft = 60
        }
    }
    
    func pauseTimers(){
        if whichTimer == rest{
            restTimer?.invalidate()
        } else if whichTimer == workout{
            workoutTimer?.invalidate()
        }
    }
    
    func resumeTimers(){
        if whichTimer == workout{
            runWorkoutTimer()
        } else if whichTimer == rest{
            runRestTimer()
        }
    }
    
    
    

}

