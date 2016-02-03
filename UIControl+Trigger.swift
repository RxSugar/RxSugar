import UIKit
import RxSwift

public protocol UIControlType: NSObjectProtocol {
	typealias ControlType: UIControl = Self
}

extension UIControlType {
	private func typedSelf() -> ControlType {
		return self as! ControlType
	}
	
	public func rxs_controlEvents<T>(eventTypes: UIControlEvents, valueGenerator: (Self)->T) -> Observable<T> {
		let trigger = Trigger { return valueGenerator(self) }
		typedSelf().addTarget(trigger, action: trigger.action, forControlEvents: eventTypes)
		rx_disposeBag ++ AnonymousDisposable { [weak self] in
			self?.typedSelf().removeTarget(trigger, action: trigger.action, forControlEvents: eventTypes)
		}
		return trigger.events
	}
	
	public func rxs_controlEvents(eventTypes: UIControlEvents) -> Observable<Void> {
		return rxs_controlEvents(eventTypes, valueGenerator: { _ in })
	}
}

extension UIControl: UIControlType {}