import RxSwift

public struct ValueSetter<HostType: AnyObject, T>: ObserverType {
	public typealias E = T
	private weak var host: HostType?
	private let setter: (HostType, T)->()
	
	public init(host: HostType, setter: @escaping (HostType, T)->()) {
		self.host = host
		self.setter = setter
	}
	
	public func on(_ event: Event<T>) {
		guard case .next(let value) = event, let host = host else { return }
		setter(host, value)
	}
}
