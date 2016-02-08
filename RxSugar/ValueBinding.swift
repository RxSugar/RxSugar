import RxSwift

/**
A reactive wrapper for readwrite control properties. This is intended for use on controls whose value changes due to a user action.

See UITextField+Sugar.swift for an example
*/
public final class ValueBinding<E>: ObserverType, ObservableType {
	private let setter: (E)->()
	private let observable: Observable<E>
	
    public init<O: ObservableType where E == O.E>(observable: O, setValue: (E)->()) {
		self.observable = observable.asObservable()
		self.setter = setValue
	}
	
	public func on(event: Event<E>) {
		guard case .Next(let value) = event else { return }
		setter(value)
	}
	
	public func subscribe<O: ObserverType where O.E == E>(observer: O) -> Disposable {
		return observable.subscribe(observer)
	}
}