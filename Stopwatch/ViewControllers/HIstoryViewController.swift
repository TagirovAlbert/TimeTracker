//
//  HIstoryViewController.swift
//  Stopwatch
//
//  Created by Albert Tagirov on 27.05.2018.
//  Copyright © 2018 Albert Tagirov. All rights reserved.
//

import UIKit
import FSCalendar
import RealmSwift

class HistoryViewController: UIViewController {
    
    var workItemsInDay = [(WorkItem, Double)](){
        didSet{
            tableView.reloadData()
        }
    }
        
    
    
    var tempWorkItems = [(WorkItem, Double)]()
    let realm = try! Realm()
    let gregorian = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        
        calendar.select(Date())
        getWorkItemsInDay(date: Date())
        let zeroView = UIView(frame: .zero)
        zeroView.backgroundColor = UIColor.black
        tableView.tableFooterView = zeroView
        
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewDidLoad()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getWorkItemsInDay(date: Date){
        workItemsInDay.removeAll()
        tempWorkItems.removeAll()
        let dayStart = Calendar.current.startOfDay(for: date)
        let dayEnd: Date = {
            // поправить вытаскивание даты
            let components = DateComponents(day: 1, second: -1)
            return Calendar.current.date(byAdding: components, to: dayStart)!
        }()
        let predicate = NSPredicate(format: "date BETWEEN %@", [dayStart, dayEnd] )
        let selectDayWorkItems = self.realm.objects(WorkItem.self).filter(predicate)
        selectDayWorkItems.forEach { (workItem) in
            sumOfTimeForWorkItem(itemWork: workItem)
        }
        workItemsInDay = tempWorkItems.sorted( by: { $0.1 > $1.1 })
    }
    
    
    func sumOfTimeForWorkItem(itemWork: WorkItem){
        print("\(itemWork.task) \(itemWork.timer) \(itemWork.date)")
        let itemForSave = WorkItem(task: Task(name: itemWork.task.name), timer: itemWork.timer, date: itemWork.date)
        
        var newItem = (itemForSave, itemForSave.timer)
        
        guard !tempWorkItems.isEmpty else { return tempWorkItems.append(newItem) }
        
        if let index = tempWorkItems.index(where: { $0.0.task.name == itemForSave.task.name}){
            newItem = (itemForSave, tempWorkItems[index].1 + itemForSave.timer)
            tempWorkItems.remove(at: index)
        }
        tempWorkItems.append(newItem)
        
    }
    
    
    func dateToStr(timeOfItem: TimeInterval) -> String{
        let minutes = Int(timeOfItem / 60)
        let seconds = Int(timeOfItem.truncatingRemainder(dividingBy: 60))
        let tenOfSeconds = Int((timeOfItem * 10).truncatingRemainder(dividingBy: 10))
        return String(format: "%02d:%02d.%d", minutes,seconds,tenOfSeconds)
    }
    
    
    

}

extension HistoryViewController: FSCalendarDelegate{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        getWorkItemsInDay(date: date)
        
    }
    
}


extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workItemsInDay.count
        
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workItemCell") as! WorkItemTableViewCell
        let name = workItemsInDay[indexPath.item].0.task.name
        let interval = workItemsInDay[indexPath.item].1
        
        cell.taskName.text = name
        cell.interval.text = dateToStr(timeOfItem: interval)
        return cell
    }
}
