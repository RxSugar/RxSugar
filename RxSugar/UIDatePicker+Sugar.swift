import RxSwift

public extension Sugar where HostType: UIDatePicker {
	/**
	RxSugar wrapper for date property.
	*/
    var date: ValueBinding<Date> {
        return controlValueBinding(
            valueChangeEventTypes: UIControl.Event.valueChanged,
            getter: { $0.date },
            setter: { $0.date = $1 })
    }
}
