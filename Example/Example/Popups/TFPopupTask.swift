//
//  TFPopupTask.swift
//  Example
//
//  Created by vodka on 2023/11/25.
//

import Foundation
import TFPopup
class TFPopupTask: PopupTask {
    var manager: Popup.Manager?
    
    var taskDescription: String
    
    var priority: Int
    
    var isCanceled: Bool = false
    
    weak private(set) var viewController: UIViewController?

    init(taskDescription: String, priority: Int, viewController: UIViewController) {
        self.taskDescription = taskDescription
        self.priority = priority
        self.viewController = viewController
    }
    func close(block: (() -> Void)?) {
        UIView.tf_findPopup("id").tf_hide()
        block?()
    }
    
    func render() {
        let alertView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 350))
        alertView.identifier = "id"
        alertView.backgroundColor = .red
        alertView.tf_showNormal(self.viewController?.view, animated: true)
        alertView.tf_observerDelegateProcess { view, process in
            if process == .didHide {
                try? self.resignFocus()  //记得调用
            }
        }
        
    }
    
    
}
