//
//  PopupTask.swift
//  Popup
//
//  Created by zhutianren on 2021/1/22.
//

import Foundation

public protocol PopupTask: AnyObject, PopupTaskLifeCycle, CustomStringConvertible, CustomDebugStringConvertible {
    
    /// a task keep a weak reference to its parent manager, the ownership should be `weak`
    var manager: Popup.Manager? { get set }
    
    /// custom description for a task
    var taskDescription: String { get set }
    
    /// priority, ascend order
    var priority: Int { get }
    
    /// cancel flag, if a task wants to cancel itself, it could flag `isCanceled` true during `willShow()`
    var isCanceled: Bool { get set }
        
    /// 关闭当前弹框,当高优先级的弹框进入队列,会调用此方法进行移除.移除存在异步操作,添加回调
    func close(finishCallback: (()->Void)?)
    
    /// when the user interaction is done for the popup, its responsibility is invoking to continue the loop
    func resignFocus()
    
    /// a right place to show popup user interface, the task will not restrict the way how you show it
    func render(dismissBlock: (() -> Void)?)
}

extension PopupTask {

    public var description: String { taskDescription }
    public var debugDescription: String { taskDescription }
    
}

extension PopupTask {
    var highLevel: Bool { false }
}

public protocol PopupTaskLifeCycle {
    
    func willShow()
    func didCanceled()
    func didShow()
    func willDismiss()
    func didDismiss()
}

public extension PopupTaskLifeCycle {
    
    func willShow() { }
    func didCanceled() { }
    func didShow() { }
    func willDismiss() { }
    func didDismiss() { }
}

/// Type erasure type for `PopupTask`
public class AnyPopupTask: PopupTask {
    
    public func close(finishCallback: (() -> Void)?) {
        self.base.close(finishCallback: finishCallback)
    }
    
    public let base: PopupTask
    
    init(_ base: PopupTask) {
        self.base = base
    }
    
    public weak var manager: Popup.Manager? {
        get { base.manager }
        set { base.manager = newValue }
    }
    
    public var taskDescription: String {
        get { base.taskDescription }
        set { base.taskDescription = newValue }
    }
    public var priority: Int { base.priority }
    public var isCanceled: Bool {
        get { base.isCanceled }
        set { base.isCanceled = newValue}
    }
    
    public func resignFocus() {
        base.resignFocus()
    }
    
    public func render(dismissBlock: (() -> Void)?) {
        base.render(dismissBlock: dismissBlock)
    }
    
    // popup task life cycle
    public func willShow() {
        base.willShow()
    }
    
    public func didCanceled() {
        base.didCanceled()
    }
    
    public func didShow() {
        base.didShow()
    }
    
    public func willDismiss() {
        base.willDismiss()
    }
    
    public func didDismiss() {
        base.didDismiss()
    }
}

extension AnyPopupTask: Comparable {
    
    public static func < (lhs: AnyPopupTask, rhs: AnyPopupTask) -> Bool {
        lhs.priority < rhs.priority
    }
    
    public static func == (lhs: AnyPopupTask, rhs: AnyPopupTask) -> Bool {
        lhs.priority == rhs.priority
    }
}

extension AnyPopupTask: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String { taskDescription }
    public var debugDescription: String { taskDescription }
}
