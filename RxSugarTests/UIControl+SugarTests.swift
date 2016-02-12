import UIKit
import RxSugar
import XCTest

protocol TestControl {}

extension TestControl where Self: UIControl {
	// best approximation of UIControl behavior without running UI tests
	func fireControlEvents(controlEvents: UIControlEvents) {
		self.allTargets().forEach { target in
			self.actionsForTarget(target, forControlEvent: controlEvents)?.forEach { action in
				target.performSelector(NSSelectorFromString(action))
			}
		}
	}
}

private class Control<T>: UIControl, TestControl {
	var value: T
    
    init(_ initialValue: T) {
        value = initialValue
        super.init(frame: CGRect.zero)
    }
}

class UIControl_TriggerTests: XCTestCase {
	func testControlSendsEvents() {
		let testObject = Control("")
		let eventStream = testObject.rxs.controlEvents([UIControlEvents.AllEvents]) {
			return $0.value
        }
		
		var events: [String] = []
		_ = eventStream.subscribeNext { events.append($0) }
		
		testObject.value = "Major Tom"
		testObject.fireControlEvents([.ValueChanged])
		XCTAssertEqual(events, ["Major Tom"])
		
		testObject.value = "Ground Control"
		testObject.fireControlEvents([.TouchDown])
		XCTAssertEqual(events, ["Major Tom", "Ground Control"])
    }
    
    func testControlSendsOnlyEventsSubscribedTo() {
        let testObject = Control("")
        let eventStream = testObject.rxs.controlEvents([.ValueChanged]) {
            return $0.value
        }
        
        var events: [String] = []
        _ = eventStream.subscribeNext { events.append($0) }
        
        testObject.value = "Major Tom"
        testObject.fireControlEvents([.TouchDragInside])
        XCTAssertEqual(events, [])
        
        testObject.value = "Ground Control"
        testObject.fireControlEvents([.ValueChanged])
        XCTAssertEqual(events, ["Ground Control"])
    }
    
    func testControlSendsCompleteOnDeinit() {
        var testObject:Control? = Control(false)
        let eventStream = testObject!.rxs.controlEvents([.ValueChanged]) {
            return $0.value
        }
        
        var events: [Bool] = []
        _ = eventStream.subscribeCompleted { events.append(true) }
        
        testObject = nil
        
        XCTAssertEqual(events, [true])
    }
}