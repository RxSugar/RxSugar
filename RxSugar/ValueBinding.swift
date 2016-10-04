import RxSwift

/**
A reactive wrapper for readwrite control properties. This is intended for use on controls whose value changes due to a user action.

See UITextField+Sugar.swift for an example
*/
public final class ValueBinding<E>: ObserverType, ObservableType {
	private let setter: AnyObserver<E>
	private let observable: Observable<E>
	
	public init<Getter: ObservableType, Setter: ObserverType>(getter: Getter, setter: Setter) where Getter.E == E, Setter.E == E {
		self.observable = getter.asObservable()
		self.setter = setter.asObserver()
	}
	
	public func on(_ event: Event<E>) {
		guard case .next(let value) = event else { return }
		setter.onNext(value)
	}
	
	public func subscribe<O: ObserverType>(_ observer: O) -> Disposable where O.E == E {
		return observable.subscribe(observer)
	}
}
