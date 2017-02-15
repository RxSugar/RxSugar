import UIKit
import RxSugar
import RxSwift
import XCTest

class UIApplication_SugarTests: XCTestCase {
    func testNSObjectSendsSignificantTimeChangeEvents() {
        let testObject = NSObject()
        let eventStream = testObject.rxs.significantTimeChange
        
        var events: [Bool] = []
        _ = eventStream.subscribe(onNext: { events.append(true) })
        
        NotificationCenter.default.post(name: NSNotification.Name.UIApplicationSignificantTimeChange, object: nil)
        XCTAssertEqual(events, [true])
        
        NotificationCenter.default.post(name: NSNotification.Name.UIApplicationSignificantTimeChange, object: nil)
        XCTAssertEqual(events, [true, true])
    }
    
    func testSignificantTimeChangeEventsDontSendAfterDealloc() {
        var events: [Bool] = []
        weak var testObject: NSObject? = nil

        autoreleasepool {
            var strongObject: NSObject? = NSObject()
            testObject = strongObject
            
            _ = testObject?.rxs.significantTimeChange.subscribe(onNext: {
                events.append(true)
            })
            
            NotificationCenter.default.post(name: NSNotification.Name.UIApplicationSignificantTimeChange, object: nil)
            XCTAssertEqual(events, [true])
            
            strongObject = nil
            
            NotificationCenter.default.post(name: NSNotification.Name.UIApplicationSignificantTimeChange, object: nil)
            XCTAssertEqual(events, [true])
        }

        XCTAssertEqual(events, [true])
    }
}
