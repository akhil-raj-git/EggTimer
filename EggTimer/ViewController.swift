//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var player: AVAudioPlayer!

    let eggTimes: [String : Int] = [
        "Soft": 5,
        "Medium": 7,
        "Hard": 12
    ]
    
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
            (Timer) in
            if self.secondsPassed < self.totalTime {
                self.secondsPassed += 1
                
                let percentageProgress = Float(self.secondsPassed) / Float(self.totalTime)
                self.progressBar.progress = percentageProgress
            } else {
                self.playSound()
                self.titleLabel.text = "DONE"
                Timer.invalidate()
            }
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
