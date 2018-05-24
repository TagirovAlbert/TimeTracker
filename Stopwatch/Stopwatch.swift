//
//  Stopwatch.swift
//  Stopwatch
//
//  Created by Albert Tagirov on 24.05.2018.
//  Copyright © 2018 Albert Tagirov. All rights reserved.
//

import Foundation

class Stopwatch{
    
    private var startTime: NSDate?
    
    var elapsTime: TimeInterval{
        if let startTime = self.startTime{
            return -startTime.timeIntervalSinceNow
        }else{
            return 0
        }
    }
    
    var isRunning: Bool{
        return startTime != nil
    }
    
    func start(){
        startTime = NSDate()
    }
    
    func stop(){
        startTime = nil
    }
    
}
