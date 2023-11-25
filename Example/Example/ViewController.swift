//
//  ViewController.swift
//  Example
//
//  Created by zhutianren on 2021/1/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Popup.Manager.shared.configuration = Configuration(timeInterval: .constant(seconds: 1))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let task1 = ExamplePopupTask(priority: 6, description: "Advertisement Popup", viewController: self)
//        task1.willShowBlock = { task in
//            task.isCanceled = false
//        }
        let task4 = LeeAlertTask(priority: 0, desc: "LEEAlert")

        let task2 = ExamplePopupTask(priority: 4, description: "Pause Popup", viewController: self)
//        task2.willShowBlock = { task in
//            task.isCanceled = false
//        }
        let task3 = ExamplePopupTask(priority: 2, description: "Notification Popup", viewController: self)
//        task3.willShowBlock = { task in
//            task.isCanceled = false
//        }
        let task5 = TFPopupTask(taskDescription: "TFPopupTask", priority: 9, viewController: self)
        
        let task6 = LeeAlertTask(priority: 5, desc: "LEEAlert-TASK")

        
        do {
            try Popup.Manager.shared.add(task: task4)
            try Popup.Manager.shared.add(task: task3)
            try Popup.Manager.shared.add(task: task1)
            try Popup.Manager.shared.add(task: task2)
            try Popup.Manager.shared.add(task: task5)
            try Popup.Manager.shared.add(task: task6)
        } catch {
            print(error)
        }
    }


}

