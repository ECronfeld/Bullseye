//
//  ViewController.swift
//  Bullseye
//
//  Created by admin on 25/10/2018.
//  Copyright © 2018 Emil Cronfeld. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var sliderValue : Int = 0
    var targetValue : Int = 0
    var score : Int = 0
    var roundNumber : Int = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var maxSliderValue: UILabel!
    @IBOutlet weak var minSliderValue: UILabel!
    @IBOutlet weak var objectiveText: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
        loadStaticLabels()
        updateLabels()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func showAlert(){
        calculateScore()
        let difference = abs(sliderValue - targetValue)
        
        let message = "The value of the slider is: \(sliderValue)" + "\nThe target value is: \(targetValue)" + "\nThe difference is: \(difference)"
        
        let alert = UIAlertController(title: motivationalAlertTitle(difference), message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        startNewRound()
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        sliderValue = Int(round(slider.value))
    }
    
    func startNewRound(){
        targetValue = Int.random(in: 1 ... 100)
        //If the min and maximum of the slider changes
        //This needs to be changed aswell
        sliderValue = 50
        slider.value = 50
        roundNumber+=1
        updateLabels()
    }
    
    @IBAction func startOver(_ sender: Any) {
        roundNumber = 0
        score = 0
        startNewRound()
    }
    
    func loadStaticLabels(){
        maxSliderValue.text = String(Int(slider.maximumValue))
        minSliderValue.text = String(Int(slider.minimumValue))
    }
    
    func updateLabels(){
        objectiveText.text = "Put the bull's eye as close to \(targetValue) as possible!"
        scoreLabel.text = "\(score)"
        roundLabel.text = "\(roundNumber)"
    }
    
    func calculateScore(){
        let maximumscore = 100;
        score = score + maximumscore - abs(sliderValue - targetValue)
    }
    
    func motivationalAlertTitle(_ difference: Int) -> String{
        var returnString : String = "Come on! You can do better"
        if(difference == 0){
            returnString = "Woah! You beast"
        } else if (difference < 5){
            returnString = "So close!"
        }
    return returnString
    }
    
}

