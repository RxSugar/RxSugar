import RxSwift

extension Sugar where HostType: UIButton {
	public var tap: Observable<Void> { return controlEvents(.TouchUpInside) }
}