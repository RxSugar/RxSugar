import RxSwift

extension RxSugarExtensions where HostType: UITextField {
	var text: ValueBinding<String> {
		return controlValueBinding(
            valueChangeEventTypes: .EditingChanged,
			valueGetter: { $0.text ?? "" },
			valueSetter: { control, value in
				control.text = value
		})
	}
	
	var attributedText: ValueBinding<NSAttributedString> {
		return controlValueBinding(
            valueChangeEventTypes: .EditingChanged,
			valueGetter: { $0.attributedText ?? NSAttributedString() },
			valueSetter: { control, value in
				control.attributedText = value
		})
	}
}