import RxSwift

/**
A reactive wrapper for readwrite control properties. This is intended for use on controls whose value changes due to a user action.

See UITextField+Sugar.swift for an example
*/
public final class ValueBinding<Element>: ObserverType, ObservableType {
	private let setter: AnyObserver<Element>
	private let observable: Observable<Element>
	
	public init<Getter: ObservableType, Setter: ObserverType>(getter: Getter, setter: Setter) where Getter.Element == Element, Setter.Element == Element {
		self.observable = getter.asObservable()
		self.setter = setter.asObserver()
	}
	
	public func on(_ event: Event<Element>) {
		guard case .next(let value) = event else { return }
		setter.onNext(value)
	}
	
	public func subscribe<Observer: ObserverType>(_ observer: Observer) -> Disposable where Observer.Element == Element {
		return observable.subscribe(observer)
	}
}
