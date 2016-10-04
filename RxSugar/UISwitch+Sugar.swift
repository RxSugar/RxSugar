import RxSwift

public extension Sugar where HostType: UISwitch {
	/**
	RxSugar wrapper for on property.
	*/
    public var on: ValueBinding<Bool> {
        return controlValueBinding(
            valueChangeEventTypes: .valueChanged,
            getter: { $0.isOn },
            setter: { $0.isOn = $1 })
    }
}
