import RxSwift

/**
A reactive wrapper for readwrite control properties. This is intended for use on controls whose value changes due to a user action.

See UITextField+Sugar.swift for an example
*/
public final class ValueBinding<E>: ObserverType, ObservableType {
	private let setter: AnyObserver<E>
	private let observable: Observable<E>
	
	public init<Getter: ObservableType, Setter: ObserverType where Getter.E == E, Setter.E == E>(getter: Getter, setter: Setter) {
		self.observable = getter.asObservable()
		self.setter = setter.asObserver()
	}
	
	public func on(_ event: Event<E>) {
		guard case .next(let value) = event else { return }
		setter.onNext(value)
	}
	
	public func subscribe<O: ObserverType where O.E == E>(_ observer: O) -> Disposable {
		return observable.subscribe(observer)
	}
}
