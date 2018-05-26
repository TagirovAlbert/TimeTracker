//
//  HIstoryViewController.swift
//  Stopwatch
//
//  Created by Albert Tagirov on 27.05.2018.
//  Copyright © 2018 Albert Tagirov. All rights reserved.
//

import UIKit
import FSCalendar

class HistoryViewController: UIViewController {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


//extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//    }
//    
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//    }
//    
//    
//}
