import Foundation
import RxSugar
import XCTest

class TriggerTests: XCTestCase {
	func testTriggerSendsEventWhenFiredViaPerformSelector () {
		let testObject = TargetActionTrigger { return 42 }
		
		var events: [Int] = []
		_ = testObject.events.subscribeNext { events.append($0) }
		
		testObject.performSelector("trigger")
		XCTAssertEqual(events, [42])
		
		testObject.performSelector("trigger")
		XCTAssertEqual(events, [42, 42])
	}
	
	func testTriggerSendsCompleteEventWhenDeinited () {
		var testObject: TargetActionTrigger<Int>? = TargetActionTrigger { return 42 }
		
		var complete = false
		_ = testObject?.events.subscribeCompleted { complete = true }
		
		
		XCTAssertFalse(complete)
		testObject = nil
		XCTAssertTrue(complete)
	}
}

