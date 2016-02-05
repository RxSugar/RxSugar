import UIKit
import RxSwift

public protocol UIControlType: NSObjectProtocol {
    typealias ControlType: UIControl = Self
}

extension UIControl: UIControlType {}

public extension Sugar where HostType: UIControl {
	public func triggerForControlEvents<T>(controlEvents: UIControlEvents, valueGetter: (HostType)->T) -> Observable<T> {
		let trigger = TargetActionObservable<T>(
			valueGenerator: { [weak host] in
				guard let this = host else { throw RxsError() }
				return valueGetter(this)
			},
			subscribe: { (target, action) in
				self.host.addTarget(target, action: action, forControlEvents: controlEvents)
			},
			unsubscribe:{ [weak host] (target, action) in
				host?.removeTarget(target, action: action, forControlEvents: controlEvents)
		},
            complete: onDeinit)
        return trigger.asObservable()
    }
    
    public func controlEvents<T>(controlEvents: UIControlEvents, valueGetter: (HostType)->T) -> Observable<T> {
        return triggerForControlEvents(controlEvents, valueGetter: valueGetter)
    }
    
    public func controlEvents(controlEvents: UIControlEvents) -> Observable<Void> {
        return self.controlEvents(controlEvents, valueGetter: { _ in })
    }
    
    public func controlValueBinding<T>(valueChangeEventTypes valueChangeEventTypes: UIControlEvents, valueGetter: (HostType)->T, valueSetter: (HostType, T)->()) -> ValueBinding<T> {
        return ValueBinding(
            observable: triggerForControlEvents(valueChangeEventTypes, valueGetter: valueGetter),
            setValue: { [weak host] in
                guard let host = host else { return }
                valueSetter(host, $0)
            })
    }
}