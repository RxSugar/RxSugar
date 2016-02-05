import RxSwift

public final class ValueBinding<E>: ObserverType, ObservableType {
	private let setter: (E)->()
	private let observable: Observable<E>
	
	public init(observable: Observable<E>, setValue: (E)->()) {
		self.observable = observable
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