import RxSwift

public struct ValueSetter<HostType: AnyObject, T>: ObserverType {
	public typealias E = T
	private weak var host: HostType?
	private let setter: (HostType, T)->()
	
	public init(host: HostType, setter: (HostType, T)->()) {
		self.host = host
		self.setter = setter
	}
	
	public func on(event: Event<T>) {
		guard case .Next(let value) = event, let host = host else { return }
		setter(host, value)
	}
}