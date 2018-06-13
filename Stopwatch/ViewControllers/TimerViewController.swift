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
    var currTimer: TimeInterval?
    
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var startStopLabel: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            currTimer = watch.elapsTime
            watch.stop()
            updateStartStopButton(str: "Старт", imageName: "startOval", color: #colorLiteral(red: 0.3215686275, green: 0.7137254902, blue: 0.2509803922, alpha: 1))
            performSegue(withIdentifier: "saveWorkItem", sender: nil)
        }else{
            timerStart()
            updateStartStopButton(str: "Стоп", imageName: "stopOval", color: #colorLiteral(red: 0.7647058824, green: 0.2745098039, blue: 0.2745098039, alpha: 1))
        }
    }
    
    private func updateStartStopButton(str: String, imageName: String, color: UIColor){
        startStopLabel.text = str
        startStopLabel.textColor = color
        startStopButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    private func timerStart(){
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateElaspedTimeLabel(timer:)), userInfo: nil, repeats: true)
        watch.start()
    }
    
  
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) {
        if segue.source is SaveTimeViewController{
            timerLabel.text = "00:00.0"
            
        }
    }
    
    @IBAction func alertWithSaveVC2(segue: UIStoryboardSegue){
        if let sourceVC = segue.source as? SaveTimeViewController{
            timerLabel.text = "00:00.0"
            saveAlert(timer: sourceVC.timeOfItemString, task: sourceVC.tasks[sourceVC.selectedIndex!].name)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveWorkItem"{
            let vc = segue.destination as! UINavigationController
            let saveVC = vc.viewControllers.first as! SaveTimeViewController
            saveVC.timeOfItem = currTimer
            saveVC.timeOfItemString = "Ваше время: \(timerLabel.text!)"
        }
    }
    
    
    private func saveAlert(timer: String, task: String){
        let alert = UIAlertController(title: "Сохранено", message: "\(timer). Ваш таск: \(task). Просмотреть результаты вы можете в Истории", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    


}

