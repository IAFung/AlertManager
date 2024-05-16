//
//  PopUpTask1.swift
//  Example
//
//  Created by zhutianren on 2021/1/25.
//

import Foundation
import UIKit
import LEEAlert

class LeeAlertTask: PopupTask {
    
    weak var manager: Popup.Manager?
    
    var taskDescription: String
    
    var priority: Int
    
    var isCanceled: Bool = false
    
//    var willShowBlock: ((PopUpTask1) -> Void)?
    
    deinit {
        print("\(taskDescription) deinit")
    }
    
    init(priority: Int, desc: String) {
        self.priority = priority
        self.taskDescription = desc
    }
    func close(finishCallback: (() -> Void)?) {
        LEEAlert.close(withIdentifier: "id") {
            finishCallback?()
        }
    }
    func render(dismissBlock: (() -> Void)?) {
        let alert = LEEAlert.alert()
           _ = alert.config
             .leeTitle("提示")
             .leeContent(taskDescription)
             .leeAction("确定", {
                 dismissBlock?() //记得调用
             })
             .leeIdentifier("id")
             .leeShow()
    }
}


