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
        let task4 = LeeAlertTask(priority: 4, desc: "task4")

        let task1 = ExamplePopupTask(priority: 1, description: "task1", viewController: self)
//        task1.willShowBlock = { task in
//            task.isCanceled = false
//        }
        let task7 = ExamplePopupTask(priority: 7, description: "task7", viewController: self)


        let task2 = ExamplePopupTask(priority: 2, description: "task2", viewController: self)
//        task2.willShowBlock = { task in
//            task.isCanceled = false
//        }
        let task3 = ExamplePopupTask(priority: 3, description: "task3", viewController: self)
        task3.willShowBlock = { task in
            task.isCanceled = true
        }
        let task5 = TFPopupTask(taskDescription: "task5", priority: 5, viewController: self)
        
        let task6 = LeeAlertTask(priority: 6, desc: "task6")

        
        do {
            try Popup.Manager.shared.add(task: task1)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                try? Popup.Manager.shared.add(task: task4)
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                try? Popup.Manager.shared.add(task: task3)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                try? Popup.Manager.shared.add(task: task5)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                try? Popup.Manager.shared.add(task: task6)
            }

//            try Popup.Manager.shared.add(task: task4)
//            try Popup.Manager.shared.add(task: task1)
//            try Popup.Manager.shared.add(task: task2)
//            try Popup.Manager.shared.add(task: task6)
        } catch {
            print(error)
        }
    }


}

