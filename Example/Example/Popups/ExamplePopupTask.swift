//
//  ExamplePopupTask.swift
//  Example
//
//  Created by zhutianren on 2021/1/25.
//

import Foundation
import UIKit

class ExamplePopupTask: PopupTask {
    
    weak var manager: Popup.Manager?
    
    var taskDescription: String
    
    var priority: Int
    
    var isCanceled: Bool = false
        
    weak private(set) var viewController: UIViewController?
    
    var willShowBlock: ((ExamplePopupTask) -> Void)?
    
    deinit {
        print("\(taskDescription) deinit")
    }
    
    init(priority: Int, description: String, viewController: UIViewController) {
        self.priority = priority
        self.taskDescription = description
        self.viewController = viewController
    }
    
    func close(finishCallback: (() -> Void)?) {
        viewController?.dismiss(animated: true) {
            finishCallback?()
        }
    }
    func render(dismissBlock: (() -> Void)?) {
        let alertViewController = UIAlertController(title: taskDescription, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            dismissBlock?()
        }
        
        alertViewController.addAction(action)
        
        viewController?.present(alertViewController, animated: true, completion: nil)
    }
    
}

extension ExamplePopupTask {
    
    func willShow() {
        willShowBlock?(self)
    }
}
