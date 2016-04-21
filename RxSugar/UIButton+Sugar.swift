import UIKit
import RxSwift

public extension UIButton {
    public static func primaryActionEvent() -> UIControlEvents {
        #if os(iOS)
            return .TouchUpInside
        #elseif os(tvOS)
            return .PrimaryActionTriggered
        #endif
    }
}

extension Sugar where HostType: UIButton, HostType: RXSObject {
	/**
	Observable<Void> that sends event for every .TouchUpInside (iOS) or .PrimaryActionTriggered (tvOS) control event
	*/
	public var tap: Observable<Void> {
        return controlEvents(UIButton.primaryActionEvent())
    }
}