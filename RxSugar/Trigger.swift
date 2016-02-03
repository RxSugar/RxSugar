import Foundation
import RxSwift

public class Trigger<T>: NSObject {
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