import Foundation
import RxSwift
import RxSugar
import XCTest

class ValueTestObject {
	var value:Int = 2
	private var trigger: Trigger<Int>? = nil
	
	init() {
		trigger = Trigger(valueGenerator: { return self.value })
	}
	
	func fireValueChangeEvent() {
		trigger?.trigger()
	}
	
	func simpleBinding() -> ValueBinding<Int> {
		return ValueBinding<Int>(
			getValueTrigger: trigger!,
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
