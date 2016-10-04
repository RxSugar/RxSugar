import Foundation
import RxSwift
import RxSugar
import XCTest

class TargetActionObservableTests: XCTestCase {
	func testObservableEventsUponPerformSelector () {
		let testObject = TargetActionObservable<Int>(
            valueGenerator: { _ in
                return 42
            },
            subscribe: { _ in },
            unsubscribe: { _ in },
            complete: self.rxs.onDeinit
        )
		
		var events: [Int] = []
        _ = testObject.subscribe(onNext: { events.append($0) })
        
		testObject.perform(testObject.actionSelector)
		XCTAssertEqual(events, [42])
		
		testObject.perform(testObject.actionSelector)
		XCTAssertEqual(events, [42, 42])
	}
	
	func testObservableCompletesUponCompletionEvent() {
        let completeSubject = PublishSubject<Void>()
        
		let testObject: TargetActionObservable<Int> = TargetActionObservable(
            valueGenerator: { _ in return 42 },
            subscribe: { _ in },
            unsubscribe: { _ in },
            complete: completeSubject
        )
		
		var complete = false
        _ = testObject.subscribe(onCompleted: { complete = true })
		
		XCTAssertFalse(complete)
		completeSubject.onNext()
		XCTAssertTrue(complete)
	}
}

