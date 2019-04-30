import RxSwift

extension Variable: ObserverType, ObservableConvertibleType {
	public func on(_ event: Event<Element>) {
		if case .next(let element) = event {
			value = element
		}
	}
}
