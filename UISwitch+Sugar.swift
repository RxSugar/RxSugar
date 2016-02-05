import RxSwift

public extension RxSugarExtensions where HostType: UISwitch {
    public var on: ValueBinding<Bool> {
        return controlValueBinding(
            valueChangeEventTypes: .ValueChanged,
            valueGetter: { $0.on },
            valueSetter: { control, value in
                control.on = value
        })
    }
}