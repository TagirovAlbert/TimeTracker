//
//  WorkItem.swift
//  Stopwatch
//
//  Created by Albert Tagirov on 25.05.2018.
//  Copyright © 2018 Albert Tagirov. All rights reserved.
//

import Foundation
import RealmSwift

class WorkItem: Object{
    @objc dynamic var taskStr: String = ""
    @objc dynamic var timer: TimeInterval = TimeInterval()
    @objc dynamic var date: Date = Date()
    
    
    convenience init(taskStr: String, timer: TimeInterval, date: Date) {
        self.init()
        self.taskStr = taskStr
        self.timer = timer
        self.date = date
    }
}
