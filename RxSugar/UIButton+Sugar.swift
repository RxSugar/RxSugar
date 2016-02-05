import RxSwift

extension RxSugarExtensions where HostType: UIButton {
	public var tap: Observable<Void> { return controlEvents(.TouchUpInside) }
}