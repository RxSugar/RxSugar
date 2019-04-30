import Foundation
import RxSwift

public final class TargetActionObservable<Element>: NSObject, ObservableType {
    public typealias E = Element
    public let actionSelector = #selector(TargetActionObservable<Element>.action)
    
	private let _unsubscribe: (NSObjectProtocol, Selector) -> ()
    private let subject = PublishSubject<Element>()
    private let valueGenerator: () throws -> Element
    private let complete: Observable<Void>
	
    public init(valueGenerator generator: @escaping () throws -> Element, subscribe subscribeAction: (NSObjectProtocol, Selector) -> (), unsubscribe: @escaping (NSObjectProtocol, Selector) -> (), complete completeEvents: Observable<Void>) {
		valueGenerator = generator
		_unsubscribe = unsubscribe
        complete = completeEvents
		super.init()
		subscribeAction(self, actionSelector)
	}
	
    public convenience init<ObservedType: RXSObject>(notificationName: String, onObject: ObservedType, valueGenerator: @escaping (ObservedType) throws -> Element) {
		self.init(
            valueGenerator: { [unowned onObject] in try valueGenerator(onObject) },
			subscribe: { (target, action) in
				NotificationCenter.default.addObserver(target, selector: action, name: NSNotification.Name(rawValue: notificationName), object: onObject)
			},
			unsubscribe: { (target, _) in
				NotificationCenter.default.removeObserver(target, name: NSNotification.Name(rawValue: notificationName), object: onObject)
            },
            complete: onObject.rxs.onDeinit
		)
	}
    
    public func subscribe<Observer: ObserverType>(_ observer: Observer) -> Disposable where Observer.Element == Element {
        let subjectDisposable = subject.takeUntil(complete).subscribe(observer)
        let triggerDisposable = Disposables.create(with: { _ = self })
        return CompositeDisposable() ++ subjectDisposable ++ triggerDisposable
    }
	
    @objc func action() {
        guard let value = try? valueGenerator() else { subject.onError(RxsError()); return }
		subject.onNext(value)
	}
	
	deinit {
		subject.onCompleted()
		_unsubscribe(self, actionSelector)
	}
}
