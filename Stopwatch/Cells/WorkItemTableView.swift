//
//  WorkItemTableView.swift
//  Stopwatch
//
//  Created by Albert Tagirov on 27.05.2018.
//  Copyright © 2018 Albert Tagirov. All rights reserved.
//

import UIKit

class WorkItemTableView: UITableView {

    private var filteredWorkItems = [(WorkItem, Double)]()
    
    var workItems = [(WorkItem, Double)](){
        didSet{
            filteredWorkItems.removeAll()
            filteredWorkItems = workItems.sorted( by: { $0.1 < $1.1 })
            reloadData()
        }
    }
    
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setup()
    }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    private func setup(){
        self.delegate = self
        self.dataSource = self
        //register(WorkItemTableViewCell.self, forCellReuseIdentifier: "workItemCell")
    }
}

extension WorkItemTableView: UITableViewDelegate, UITableViewDataSource{
    
    private func dateToStr(timeOfItem: TimeInterval) -> String{
        let minutes = Int(timeOfItem / 60)
        let seconds = Int(timeOfItem.truncatingRemainder(dividingBy: 60))
        let tenOfSeconds = Int((timeOfItem * 10).truncatingRemainder(dividingBy: 10))
        return String(format: "%02d:%02d.%d", minutes,seconds,tenOfSeconds)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredWorkItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workItemCell") as! WorkItemTableViewCell
        let name = filteredWorkItems[indexPath.item].0.task.name
        let interval = filteredWorkItems[indexPath.item].1
        print( numberOfRows(inSection: 0))
        
        cell.taskName.text = name
        cell.interval.text = dateToStr(timeOfItem: interval)
        return cell
    }
    
}

