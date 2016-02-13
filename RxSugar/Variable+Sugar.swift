import RxSwift

extension Variable: ObserverType, ObservableConvertibleType {
	public func on(event: Event<E>) {
		if case .Next(let element) = event {
			value = element
		}
	}
}