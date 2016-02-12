import UIKit
import RxSwift

public extension Sugar where HostType: UIControl {
	
	/**
	Observable<T> that sends Event<T> on every event in controlEvents.
	
	- parameter controlEvents: UIControlEvents that will trigger event.
	- parameter valueGetter: closure used to determine value of the control.
	- returns: Observable<T>.
	*/
    public func controlEvents<T>(controlEvents: UIControlEvents, valueGetter: (HostType)->T) -> Observable<T> {
		let observable = TargetActionObservable<T>(
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
		return observable.asObservable()
    }
	
	
	/**
	Observable<Void> that sends event on every event in controlEvents.
	
	- parameter controlEvents: UIControlEvents that will trigger event.
	- returns: Observable<Void>.
	*/
    public func controlEvents(controlEvents: UIControlEvents) -> Observable<Void> {
        return self.controlEvents(controlEvents, valueGetter: { _ in })
    }
	
	/**
	Observable<T> that sends Event<T> on every event in controlEvents.
	
	- parameter valueChangeEventTypes: UIControlEvents that will trigger event.
	- parameter valueGetter: closure used to determine value of the control.
	- parameter valueSetter: closure used to set value of the control when event is received.
	- returns: ValueBinding<T>.
	*/
    public func controlValueBinding<T>(valueChangeEventTypes valueChangeEventTypes: UIControlEvents, getter: (HostType)->T, setter: (HostType, T)->()) -> ValueBinding<T> {
        return ValueBinding(
            getter: controlEvents(valueChangeEventTypes, valueGetter: getter),
			setter: valueSetter(setter))
	}
	
	/**
	Reactive setter for enabled property
	*/
    public var enabled: AnyObserver<Bool> {
		return valueSetter { $0.enabled = $1 }
	}
	
	/**
	Reactive setter for selected property
	*/
    public var selected: AnyObserver<Bool> {
		return valueSetter { $0.selected = $1 }
	}
}