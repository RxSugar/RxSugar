import UIKit
import RxSwift

public protocol UIControlType: NSObjectProtocol {
    typealias ControlType: UIControl = Self
}

public extension UIControlType {
    typealias RxsSelfType = Self
    
    public var rxs: RxSugarExtensions<RxsSelfType> { return RxSugarExtensions<RxsSelfType>(host: self) }
}

extension UIControl: UIControlType {}

public struct RxSugarExtensions<HostType: NSObjectProtocol> {
    private let host:HostType
    
    public init(host: HostType) {
        self.host = host
    }
}

public extension RxSugarExtensions where HostType: UIControl {
    public func triggerForControlEvents<T>(controlEvents: UIControlEvents, valueGetter: (HostType)->T) -> Trigger<T> {
        let trigger = TargetActionTrigger<T> { [weak host] in
            guard let this = host else { throw RxsError() }
            return valueGetter(this)
        }
        host.addTarget(trigger, action: trigger.action, forControlEvents: controlEvents)
        host.rx_disposeBag ++ AnonymousDisposable { [weak host] in // TODO should move this to Trigger deinit
            host?.removeTarget(trigger, action: trigger.action, forControlEvents: controlEvents)
        }
        return trigger.asTrigger()
    }
    
    public func controlEvents<T>(controlEvents: UIControlEvents, valueGetter: (HostType)->T) -> Observable<T> {
        return triggerForControlEvents(controlEvents, valueGetter: valueGetter).events
    }
    
    public func controlEvents(controlEvents: UIControlEvents) -> Observable<Void> {
        return self.controlEvents(controlEvents, valueGetter: { _ in })
    }
    
    public func controlValueBinding<T>(valueChangeEventTypes valueChangeEventTypes: UIControlEvents, valueGetter: (HostType)->T, valueSetter: (HostType, T)->()) -> ValueBinding<T> {
        return ValueBinding(
            getValueTrigger: triggerForControlEvents(valueChangeEventTypes, valueGetter: valueGetter),
            setValue: { [weak host] in
                guard let host = host else { return }
                valueSetter(host, $0)
            })
    }
}