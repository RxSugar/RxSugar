import RxSwift

#if os(iOS) || os(tvOS)
import UIKit

public extension Sugar where HostType: UIControl {
	
	/**
	Observable<T> that sends Event<T> on every event in controlEvents.
	
	- parameter controlEvents: UIControlEvents that will trigger event.
	- parameter valueGetter: closure used to determine value of the control.
	- returns: Observable<T>.
	*/
    func controlEvents<T>(_ controlEvents: UIControl.Event, valueGetter: @escaping (HostType)->T) -> Observable<T> {
		let observable = TargetActionObservable<T>(
			valueGenerator: { [weak host] in
				guard let this = host else { throw RxsError() }
				return valueGetter(this)
			},
			subscribe: { [weak host] (target, action) in
				host?.addTarget(target, action: action, for: controlEvents)
			},
			unsubscribe:{ [weak host] (target, action) in
				host?.removeTarget(target, action: action, for: controlEvents)
			},
			complete: onDeinit)
		return observable.asObservable()
    }
	
	
	/**
	Observable<Void> that sends event on every event in controlEvents.
	
	- parameter controlEvents: UIControlEvents that will trigger event.
	- returns: Observable<Void>.
	*/
    func controlEvents(_ controlEvents: UIControl.Event) -> Observable<Void> {
        return self.controlEvents(controlEvents, valueGetter: { _ in })
    }
	
	/**
	Observable<T> that sends Event<T> on every event in controlEvents.
	
	- parameter valueChangeEventTypes: UIControlEvents that will trigger event.
	- parameter valueGetter: closure used to determine value of the control.
	- parameter valueSetter: closure used to set value of the control when event is received.
	- returns: ValueBinding<T>.
	*/
    func controlValueBinding<T>(valueChangeEventTypes: UIControl.Event, getter: @escaping (HostType)->T, setter: @escaping (HostType, T)->()) -> ValueBinding<T> {

        return ValueBinding(
            getter: controlEvents(valueChangeEventTypes, valueGetter: getter),
			setter: valueSetter(setter))
	}
	
	/**
	Reactive setter for isEnabled property
	*/
    var isEnabled: AnyObserver<Bool> {
		return valueSetter { $0.isEnabled = $1 }
	}
	
	/**
	Reactive setter for isSelected property
	*/
    var isSelected: AnyObserver<Bool> {
		return valueSetter { $0.isSelected = $1 }
	}
}

#endif
