import RxSwift

public final class ValueBinding<E>: ObserverType, ObservableType {
	private let setter: (E)->()
	private let trigger: Observable<E>
	
	public init(getValueTrigger: Observable<E>, setValue: (E)->()) {
		self.trigger = getValueTrigger
		self.setter = setValue
	}
	
	public func on(event: Event<E>) {
		guard case .Next(let value) = event else { return }
		setter(value)
	}
	
	public func subscribe<O: ObserverType where O.E == E>(observer: O) -> Disposable {
		return trigger.subscribe(observer)
	}
}