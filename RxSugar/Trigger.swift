import Foundation
import RxSwift

public final class Trigger<T>: NSObject {
	let action: Selector = "trigger"
	
	private let subject = PublishSubject<T>()
	private let valueGenerator: ()->T
	public let events: Observable<T>
	
	public init(valueGenerator generator:()->T) {
		events = subject.asObservable()
		valueGenerator = generator
	}
	
	public func trigger() {
		subject.onNext(valueGenerator())
	}
	
	deinit {
		subject.onCompleted()
	}
}

