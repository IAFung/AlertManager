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
    
    var highLevel: Bool { get } //当高优先级弹框加入队列时,是否支持先移除当前弹框,之后再弹出.
    
    /// 关闭当前屏幕上的弹框
    /// 只有supportTempRemove为true时才会调用此方法
    func close(block: (()->Void)?)
    
    /// when the user interaction is done for the popup, its responsibility is invoking to continue the loop
    func resignFocus() throws
    
    /// a right place to show popup user interface, the task will not restrict the way how you show it
    func render()
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
    
    public var highLevel: Bool {
        base.highLevel
    }
    
    public func close(block: (() -> Void)?) {
        self.base.close(block: block)
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
    
    public func resignFocus() throws {
        try base.resignFocus()
    }
    
    public func render() {
        base.render()
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
