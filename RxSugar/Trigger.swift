import Foundation
import RxSwift

public protocol TriggerType {
	typealias TriggerElement
	
	var events: Observable<TriggerElement> { get }
}

extension TriggerType {
	public func asTrigger() -> Trigger<TriggerElement> {
		return Trigger(self)
	}
}


public struct Trigger<T>: TriggerType {
	public typealias TriggerElement = T
	private let getEvents: () -> Observable<TriggerElement>
	public var events: Observable<TriggerElement> { return getEvents() }
	
	public init<Type: TriggerType where Type.TriggerElement == T>(_ trigger: Type) {
		getEvents = { trigger.events }  // captures trigger reference to ensure original trigger stays alive, if necessary
	}
}

public final class TargetActionTrigger<T>: NSObject, TriggerType {
	public typealias TriggerElement = T
	let action: Selector = "trigger"
	
	private let subject = PublishSubject<T>()
	private let valueGenerator: () throws -> T
	public let events: Observable<T>
	
	public init(valueGenerator generator: () throws -> T) {
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

