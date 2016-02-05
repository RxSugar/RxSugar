import Foundation
import RxSwift
import RxSugar
import XCTest

class ValueTestObject: RXSObject {
	var value:Int = 2
	private var events: TargetActionObservable<Int>? = nil
	
	init() {
        events = TargetActionObservable(
            valueGenerator: { return self.value },
            subscribe: { _ in },
            unsubscribe: { _ in },
            complete: self.rxs.onDeinit)
	}
	
	func fireValueChangeEvent() {
        guard let events = events else { fatalError() }
		events.performSelector(events.actionSelector)
	}
	
	func simpleBinding() -> ValueBinding<Int> {
		return ValueBinding<Int>(
			observable: events!.asObservable(),
			setValue: { [unowned self] in self.value = $0 })
	}
}

class ValueBindingTests: XCTestCase {
	func testValueBindingSetsValue() {
		let testObject = ValueTestObject()
		let publishSubject = PublishSubject<Int>()
		
		publishSubject.subscribe(testObject.simpleBinding())
		
		XCTAssertEqual(testObject.value, 2)
		
		publishSubject.onNext(11)
		
		XCTAssertEqual(testObject.value, 11)
	}
	
	func testValueBindingGetsValue() {
		let testObject = ValueTestObject()
		
		var events: [Int] = []
		_ = testObject.simpleBinding().subscribeNext {
			events.append($0)
		}
		
		XCTAssertEqual(events, [])
		
		testObject.fireValueChangeEvent()
		XCTAssertEqual(events, [2])
		
		testObject.value = 7
		testObject.fireValueChangeEvent()
		XCTAssertEqual(events, [2, 7])
	}
}
