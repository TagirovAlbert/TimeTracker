//
//  Task.swift
//  Stopwatch
//
//  Created by Albert Tagirov on 25.05.2018.
//  Copyright © 2018 Albert Tagirov. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object{
    @objc dynamic var name: String = ""
    
    
    override static func primaryKey() -> String?{
        return "name"
    }
}
