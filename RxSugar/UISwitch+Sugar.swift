import RxSwift

#if os(iOS)
import UIKit

public extension Sugar where HostType: UISwitch {
	/**
	RxSugar wrapper for on property.
	*/
    var isOn: ValueBinding<Bool> {
        return controlValueBinding(
            valueChangeEventTypes: UIControl.Event.valueChanged,
            getter: { $0.isOn },
            setter: { $0.isOn = $1 })
    }
}

#endif
