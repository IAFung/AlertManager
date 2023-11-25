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
    
    var highLevel: Bool = true //不会被隐藏
        
    
//    var willShowBlock: ((PopUpTask1) -> Void)?
    
    deinit {
        print("\(taskDescription) deinit")
    }
    
    init(priority: Int, desc: String) {
        self.priority = priority
        self.taskDescription = desc
    }
    func close(block: (() -> Void)?) {
        LEEAlert.close(withIdentifier: "id") {
            block?()
        }
    }
    
    func render() {
       let alert = LEEAlert.alert()
          _ = alert.config
            .leeTitle("提示")
            .leeContent(taskDescription)
            .leeAction("确定", {
               try? self.resignFocus() //记得调用
            })
            .leeIdentifier("id")
            .leeShow()
    }
}


