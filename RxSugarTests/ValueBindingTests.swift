import Foundation
import RxSwift
import RxSugar
import XCTest

class ValueTestObject: RXSObject {
	var value:Int = 2
	private var events: TargetActionObservable<Int>!
	
	init() {
        events = TargetActionObservable(
            valueGenerator: { return self.value },
            subscribe: { _ in },
            unsubscribe: { _ in },
            complete: rxs.onDeinit)
	}
	
	func fireValueChangeEvent() {
		events.perform(events.actionSelector)
	}
	
	func simpleBinding() -> ValueBinding<Int> {
		return ValueBinding<Int>(
			getter: events,
			setter: rxs.valueSetter { $0.value = $1 })
	}
}

class ValueBindingTests: XCTestCase {
	func testValueBindingSetsValue() {
		let testObject = ValueTestObject()
		let publishSubject = PublishSubject<Int>()
		
		_ = publishSubject.subscribe(testObject.simpleBinding())
		
		XCTAssertEqual(testObject.value, 2)
		
		publishSubject.onNext(11)
		
		XCTAssertEqual(testObject.value, 11)
	}
	
	func testValueBindingGetsValue() {
		let testObject = ValueTestObject()
		
		var events: [Int] = []
        _ = testObject.simpleBinding().subscribe(onNext: {
			events.append($0)
		})
		
		XCTAssertEqual(events, [])
		
		testObject.fireValueChangeEvent()
		XCTAssertEqual(events, [2])
		
		testObject.value = 7
		testObject.fireValueChangeEvent()
		XCTAssertEqual(events, [2, 7])
	}
}
