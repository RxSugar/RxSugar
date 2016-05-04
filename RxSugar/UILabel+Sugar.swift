import UIKit
import RxSwift

public extension Sugar where HostType: UILabel {
	
	/**
	RxSugar wrapper for text property.
	*/
	public var text: AnyObserver<String> { return valueSetter { $0.text = $1 } }
	
	/**
	RxSugar wrapper for attributedText property.
	*/
	public var attributedText: AnyObserver<NSAttributedString> { return valueSetter { $0.attributedText = $1 } }
}