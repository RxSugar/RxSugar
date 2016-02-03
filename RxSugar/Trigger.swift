import Foundation
import RxSwift

public final class Trigger<T>: NSObject {
	public typealias ValueGenerator = () throws -> T
	let action: Selector = "trigger"
	
	private let subject = PublishSubject<T>()
	private let valueGenerator: ValueGenerator
	public let events: Observable<T>
	
	public init(valueGenerator generator: ValueGenerator) {
		events = subject.asObservable()
		valueGenerator = generator
	}
	
	public func trigger() {
		guard let value = try? valueGenerator() else { return }
		subject.onNext(value)
	}
	
	deinit {
		subject.onCompleted()
	}
}

