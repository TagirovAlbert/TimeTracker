//
//  ViewController.swift
//  Stopwatch
//
//  Created by Albert Tagirov on 24.05.2018.
//  Copyright © 2018 Albert Tagirov. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    let watch = Stopwatch()

    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restartButton.isHidden = true
        pauseButton.isHidden  = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func updateElaspedTimeLabel(timer: Timer){
        if watch.isRunning{
            let minutes = Int(watch.elapsTime / 60)
            let seconds = Int(watch.elapsTime.truncatingRemainder(dividingBy: 60))
            let tenOfSeconds = Int((watch.elapsTime * 10).truncatingRemainder(dividingBy: 10))
            timerLabel.text = String(format: "%02d:%02d.%d", minutes,seconds,tenOfSeconds)
        }else{
            timer.invalidate()
        }
    }
    
    
    
    @IBAction func startStopAction(_ sender: Any) {
        
        if watch.isRunning{
            watch.stop()
            startStopButton.setImage(UIImage(named: "start"), for: .normal)
            performSegue(withIdentifier: "saveWorkItem", sender: nil)
      //      restartButton.isHidden = false
      //      pauseButton.isHidden = false
        }else{
            timerStart()
        startStopButton.setImage(UIImage(named: "stop"), for: .normal)
        }
    }
    
    private func timerStart(){
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateElaspedTimeLabel(timer:)), userInfo: nil, repeats: true)
        watch.start()
    }
    
    
    @IBAction func restart(_ sender: Any) {
      //  watch.stop()
      //  timerStart()
    }
    
    
    @IBAction func pauseAction(_ sender: Any) {
    }
    

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveWorkItem"{
            let vc = segue.destination as! SaveTimeViewController
            vc.timeOfItem = watch.elapsTime
        }
    }
    
    
    
    


}

