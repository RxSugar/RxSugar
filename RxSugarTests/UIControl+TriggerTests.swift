import UIKit
import RxSugar
import XCTest

class TestControl: UIControl {
	var value: String = ""
	
	// best approximation of UIControl behavior without running UI tests
	override func sendActionsForControlEvents(controlEvents: UIControlEvents) {
		self.allTargets().forEach { target in
			self.actionsForTarget(target, forControlEvent: controlEvents)?.forEach { action in
				target.performSelector(NSSelectorFromString(action))
			}
		}
	}
}

class UIControl_TriggerTests: XCTestCase {
	func testControlSendsEvents() {
		let testObject = TestControl()
		let eventStream = testObject.events([.AllEvents]) {
			return $0.value
		}
		
		var events: [String] = []
		_ = eventStream.subscribeNext { events.append($0) }
		
		testObject.value = "Major Tom"
		testObject.sendActionsForControlEvents([.ValueChanged])
		XCTAssertEqual(events, ["Major Tom"])
		
		testObject.value = "Ground Control"
		testObject.sendActionsForControlEvents([.TouchDown])
		XCTAssertEqual(events, ["Major Tom", "Ground Control"])
	}
	
	func testControlSendsOnlyEventsSubscribedTo() {
		let testObject = TestControl()
		let eventStream = testObject.events([.ValueChanged]) {
			return $0.value
		}
		
		var events: [String] = []
		_ = eventStream.subscribeNext { events.append($0) }
		
		testObject.value = "Major Tom"
		testObject.sendActionsForControlEvents([.TouchDragInside])
		XCTAssertEqual(events, [])
		
		testObject.value = "Ground Control"
		testObject.sendActionsForControlEvents([.ValueChanged])
		XCTAssertEqual(events, ["Ground Control"])
	}
}