//
//  SaveTimeViewController.swift
//  
//
//  Created by Albert Tagirov on 25.05.2018.
//

import UIKit
import RealmSwift

class SaveTimeViewController: UIViewController {
    
    var timeOfItem: TimeInterval!
    var timeOfItemString: String!
    var selectedIndex: Int?{
        willSet{
            if newValue == nil{
                saveButton.isHidden = true
            }else{
                saveButton.isHidden = false
            }
        }
    }
    let realm = try! Realm()
    lazy var tasks: Results<Task> = { self.realm.objects(Task.self) }()
    
    @IBOutlet weak var timerLable: UILabel!
    @IBOutlet weak var tableView: UITableView!
   
    @IBOutlet weak var addNewTaskButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        saveButton.isHidden = true
        populateDefaultTasks()
        let zeroView = UIView(frame: .zero)
        zeroView.backgroundColor = UIColor.black
        tableView.tableFooterView = zeroView
        print(realm.configuration.fileURL?.absoluteString)
        timerLable.text = timeOfItemString
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        if let index = tableView.indexPathForSelectedRow{
//            tableView.deselectRow(at: index, animated: true)
//        }
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addNewTask(_ sender: Any) {
        showAddTaskAlert()
    }
    
    
    @IBAction func goBackToOneButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindToVC1WithSegue", sender: self)
    }
   
    
    
    @IBAction func saveNewWorkItem(_ sender: Any) {
        
       try! realm.write {
            let workItem = WorkItem()
            workItem.task = tasks[selectedIndex!]
        let minutes = Int(timeOfItem / 60)
        let seconds = Int(timeOfItem.truncatingRemainder(dividingBy: 60))
        let tenOfSeconds = Int((timeOfItem * 10).truncatingRemainder(dividingBy: 10))
        let str = String(format: "%02d:%02d.%d", minutes,seconds,tenOfSeconds)
        print(str)
            workItem.timer = timeOfItem
            realm.add(workItem)
        }
        
        performSegue(withIdentifier: "alertWithSaveVC2WithSegue", sender: self)
        
    }

    
}

extension SaveTimeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        selectedIndex = indexPath.row
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Task", for: indexPath)
        cell.textLabel?.textColor = .white
        if indexPath.row == selectedIndex{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        cell.textLabel?.text = tasks[indexPath.row].name
        return cell
    }
    
    private func showAddTaskAlert(){
        let alertController = UIAlertController(title: "Введите новое действие", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Введите действие"
        }
        let cancel = UIAlertAction(title: "Отмена", style:.cancel, handler: nil)
        let addTask = UIAlertAction(title: "Добавить", style: .default) { (alert) in
            let newTaskField = alertController.textFields![0] as UITextField
            if let newTask = newTaskField.text{
                try! self.realm.write {
                    let task = Task()
                    task.name = newTask
                    self.realm.add(task)
                }
                self.tasks = self.realm.objects(Task.self)
                self.selectedIndex = self.tasks.count - 1
                self.tableView.reloadData()
            }else{
                self.alertInfo(message: "Заполните поле")
            }
        }
        alertController.addAction(cancel)
        alertController.addAction(addTask)
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    func alertInfo(message: String){
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ок", style: .default, handler: nil)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    
    func populateDefaultTasks(){
        if tasks.count == 0{
            try! realm.write {
                let taskArr = ["Объяснить функционал", "Развернуть среду", "Составить таски"]
                for elem in taskArr{
                    let newTask = Task()
                    newTask.name = elem
                    self.realm.add(newTask)
                }
            }
            
            tasks = realm.objects(Task.self)
        }
    }
    
    
    
    
//    func deselectSelectedCell(){
//        if let index = tableView.indexPathForSelectedRow{
//            tableView.deselectRow(at: index, animated: true)
//        }
//    }
    
    
}









