import RxSwift

extension Variable: ObserverType, ObservableConvertibleType {
	public func on(_ event: Event<E>) {
		if case .next(let element) = event {
			value = element
		}
	}
}
