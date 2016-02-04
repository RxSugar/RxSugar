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
	
	private let _unsubscribe: (NSObjectProtocol, Selector) -> ()
	private let subject = PublishSubject<T>()
	private let valueGenerator: () throws -> T
	public let events: Observable<T>
	
	public init(valueGenerator generator: () throws -> T, subscribe: (NSObjectProtocol, Selector) -> (), unsubscribe: (NSObjectProtocol, Selector) -> ()) {
		events = subject.asObservable()
		valueGenerator = generator
		_unsubscribe = unsubscribe
		super.init()
		subscribe(self, action)
	}
	
	public convenience init (control: UIControl, forEvents controlEvents: UIControlEvents, valueGenerator generator: () throws -> T) {
		self.init(
			valueGenerator: generator,
			subscribe: { (target, action) in
				control.addTarget(target, action: action, forControlEvents: controlEvents)
			},
			unsubscribe: { (target, action) in
				control.removeTarget(target, action: action, forControlEvents: controlEvents)
			}
		)
	}
	
	public convenience init(notificationName: String, onObject: AnyObject, valueGenerator: () throws -> T) {
		self.init(
			valueGenerator: valueGenerator,
			subscribe: { (target, action) in
				NSNotificationCenter.defaultCenter().addObserver(target, selector: action, name: notificationName, object: onObject)
			},
			unsubscribe: { (target, _) in
				NSNotificationCenter.defaultCenter().removeObserver(target, name: notificationName, object: onObject)
			}
		)
	}
	
	public func trigger() {
		guard let value = try? valueGenerator() else { return }
		subject.onNext(value)
	}
	
	deinit {
		subject.onCompleted()
		_unsubscribe(self, action)
	}
}
