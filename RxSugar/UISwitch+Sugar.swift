import RxSwift

public extension Sugar where HostType: UISwitch, HostType: RXSObject {
	/**
	RxSugar wrapper for on property.
	*/
    public var on: ValueBinding<Bool> {
        return controlValueBinding(
            valueChangeEventTypes: .ValueChanged,
            getter: { $0.on },
            setter: { $0.on = $1 })
    }
}