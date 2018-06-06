import RxSugar
import XCTest

extension UIDatePicker: TestControl {}

class UIDatePicker_SugarTests: XCTestCase {
	let date1 = Date(timeIntervalSinceReferenceDate: 20)
	let date2 = Date(timeIntervalSinceReferenceDate: 50)
	
	func testSwitchSendsEvents() {
		let testObject = UIDatePicker()
		let eventStream = testObject.rxs.date
		
		var events: [Date] = []
		_ = eventStream.subscribe(onNext: { events.append($0) })
		
		testObject.date = date1
		testObject.fireControlEvents([UIControl.Event.valueChanged])
		XCTAssertEqual(events, [date1])
		
		testObject.date = date1
		testObject.fireControlEvents([UIControl.Event.valueChanged])
		testObject.fireControlEvents([UIControl.Event.editingDidEnd])
		testObject.fireControlEvents([UIControl.Event.editingChanged])
		testObject.fireControlEvents([UIControl.Event.editingDidBegin])
		XCTAssertEqual(events, [date1, date1])
		
		testObject.date = date2
		testObject.fireControlEvents([UIControl.Event.valueChanged])
		XCTAssertEqual(events, [date1, date1, date2])
	}
	
	func testSwitchUpdatesValue() {
		let testObject = UIDatePicker()
		let observer = testObject.rxs.date
		
		observer.onNext(date1)
		XCTAssertEqual(testObject.date, date1)
		
		observer.onNext(date2)
		XCTAssertEqual(testObject.date, date2)
	}
}
