import Foundation
import RxSwift
import RxSugar
import XCTest

class TargetActionTriggerTests: XCTestCase {
	func testTriggerSendsEventWhenFiredViaPerformSelector () {
		let testObject = TargetActionObservable<Int>(
            valueGenerator: { _ in
                return 42
            },
            subscribe: { _ in },
            unsubscribe: { _ in },
            complete: self.rxs.onDeinit
        )
		
		var events: [Int] = []
		_ = testObject.subscribeNext { events.append($0) }
		
		testObject.performSelector("trigger")
		XCTAssertEqual(events, [42])
		
		testObject.performSelector("trigger")
		XCTAssertEqual(events, [42, 42])
	}
	
	func testTriggerSendsCompleteEventWhenCompleteEventReceived() {
        let completeSubject = PublishSubject<Void>()
        
		let testObject: TargetActionObservable<Int> = TargetActionObservable(
            valueGenerator: { _ in return 42 },
            subscribe: { _ in },
            unsubscribe: { _ in },
            complete: completeSubject
        )
		
		var complete = false
		_ = testObject.subscribeCompleted { complete = true }
		
		XCTAssertFalse(complete)
		completeSubject.onNext()
		XCTAssertTrue(complete)
	}
}

