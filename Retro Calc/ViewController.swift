//
//  ViewController.swift
//  Retro Calc
//
//  Created by Simon Barton on 1/21/16.
//  Copyright © 2016 Simon Barton Inc. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var clearButton: UIButton!
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var buttonSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
      
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try buttonSound = AVAudioPlayer(contentsOfURL: soundUrl)
            buttonSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    
    @IBAction func clearButtonPressed(sender: UIButton) {
        outputLbl.text = "\(0)"
        runningNumber = ""
       currentOperation = Operation.Empty
    }
    
    @IBAction func numberPressed(button: UIButton!) {
        playSound()
        
        runningNumber += "\(button.tag)"
        outputLbl.text = runningNumber
    }

    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
        
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
        
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            //Run some math
            
            //A user selected an operator, but then selected another operator without
            //first entering a number.
            
            if runningNumber != "" {
                
            rightValStr = runningNumber
            runningNumber = ""
            
            if currentOperation == Operation.Multiply {
                result = "\(Double(leftValStr)! * Double(rightValStr)!)"
            }
            else if currentOperation == Operation.Divide {
                result = "\(Double(leftValStr)! / Double(rightValStr)!)"
            }
            else if currentOperation == Operation.Subtract {
                result = "\(Double(leftValStr)! - Double(rightValStr)!)"
            }
            else if currentOperation == Operation.Add {
                result = "\(Double(leftValStr)! + Double(rightValStr)!)"
            }
            
            leftValStr = result
            outputLbl.text = result
            
            }
            
            currentOperation = op
            
        } else {
            //This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
        
    }
    
    func playSound() {
        if buttonSound.playing {
            buttonSound.stop()
        }
        buttonSound.play()
    }
    
}

