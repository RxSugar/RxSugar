import UIKit
import RxSwift

public extension Sugar where HostType: UILabel {
	
	/**
	RxSugar wrapper for text property.
	*/
	public var text: AnyObserver<String> {
		let label: UILabel = self.host
		let subject = PublishSubject<String>()
		label.rxs.disposeBag ++ subject.subscribeNext { [weak label] in label?.text = $0 }
		return subject.asObserver()
	}
	
	/**
	RxSugar wrapper for attributedText property.
	*/
	public var attributedText: AnyObserver<NSAttributedString> {
		let label: UILabel = self.host
		let subject = PublishSubject<NSAttributedString>()
		label.rxs.disposeBag ++ subject.subscribeNext { [weak label] in label?.attributedText = $0 }
		return subject.asObserver()
	}
}