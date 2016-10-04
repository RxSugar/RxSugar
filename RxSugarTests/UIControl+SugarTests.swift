import UIKit
import RxSugar
import XCTest

protocol TestControl {}

extension TestControl where Self: UIControl {
	// best approximation of UIControl behavior without running UI tests
	func fireControlEvents(_ controlEvents: UIControlEvents) {
		self.allTargets.forEach { target in
			self.actions(forTarget: target, forControlEvent: controlEvents)?.forEach { action in
                _ = (target as AnyObject).perform(NSSelectorFromString(action))
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

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class UIControl_TriggerTests: XCTestCase {
	func testControlSendsEvents() {
		let testObject = Control("")
		let eventStream = testObject.rxs.controlEvents([UIControlEvents.allEvents]) {
			return $0.value
        }
		
		var events: [String] = []
        _ = eventStream.subscribe(onNext: { events.append($0) })
		
		testObject.value = "Major Tom"
		testObject.fireControlEvents([.valueChanged])
		XCTAssertEqual(events, ["Major Tom"])
		
		testObject.value = "Ground Control"
		testObject.fireControlEvents([.touchDown])
		XCTAssertEqual(events, ["Major Tom", "Ground Control"])
    }
    
    func testControlSendsOnlyEventsSubscribedTo() {
        let testObject = Control("")
        let eventStream = testObject.rxs.controlEvents([.valueChanged]) {
            return $0.value
        }
        
        var events: [String] = []
        _ = eventStream.subscribe(onNext: { events.append($0) })
        
        testObject.value = "Major Tom"
        testObject.fireControlEvents([.touchDragInside])
        XCTAssertEqual(events, [])
        
        testObject.value = "Ground Control"
        testObject.fireControlEvents([.valueChanged])
        XCTAssertEqual(events, ["Ground Control"])
    }
    
    func testControlSendsCompleteOnDeinit() {
        var testObject:Control? = Control(false)
        let eventStream = testObject!.rxs.controlEvents([.valueChanged]) {
            return $0.value
        }
        
        var events: [Bool] = []
        _ = eventStream.subscribe(onCompleted: { events.append(true) })
        
        testObject = nil
        
        XCTAssertEqual(events, [true])
    }
}
