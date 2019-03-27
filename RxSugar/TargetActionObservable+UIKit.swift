#if os(iOS) || os(tvOS)
import UIKit

extension TargetActionObservable {
	public convenience init (control: UIControl, forEvents controlEvents: UIControl.Event, valueGenerator generator: @escaping () throws -> Element) {
		self.init(
			valueGenerator: generator,
			subscribe: { (target, action) in
				control.addTarget(target, action: action, for: controlEvents)
		},
			unsubscribe: { (target, action) in
				control.removeTarget(target, action: action, for: controlEvents)
		},
			complete: control.rxs.onDeinit
		)
	}
}

#endif
