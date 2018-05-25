//
//  SaveTimeViewController.swift
//  
//
//  Created by Albert Tagirov on 25.05.2018.
//

import UIKit

class SaveTimeViewController: UIViewController {
    
    var timeOfItem: TimeInterval!
    var timeOfItemString: String!
    
    @IBOutlet weak var timerLable: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var taskArr = ["Объяснить функционал", "Развернуть среду", "Составить таски"]

    @IBOutlet weak var addNewTaskButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        tableView.tableFooterView = UIView(frame: .zero)
        timerLable.text = timeOfItemString
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

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
    }

    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}

extension SaveTimeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Task", for: indexPath)
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = taskArr[indexPath.row]
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
                self.taskArr.append(newTask)
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
    
    
}









