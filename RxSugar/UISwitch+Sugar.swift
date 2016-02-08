import RxSwift

public extension Sugar where HostType: UISwitch {
	/**
	RxSugar wrapper for on property.
	*/
    public var on: ValueBinding<Bool> {
        return controlValueBinding(
            valueChangeEventTypes: .ValueChanged,
            valueGetter: { $0.on },
            valueSetter: { control, value in
                control.on = value
        })
    }
}