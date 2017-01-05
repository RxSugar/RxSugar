import RxSwift

public extension Sugar where HostType: UIDatePicker {
	/**
	RxSugar wrapper for date property.
	*/
    public var date: ValueBinding<Date> {
        return controlValueBinding(
            valueChangeEventTypes: .valueChanged,
            getter: { $0.date },
            setter: { $0.date = $1 })
    }
}
