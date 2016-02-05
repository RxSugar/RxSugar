import UIKit
import RxSugar
import XCTest

class UITextView_SugarTests: XCTestCase {
    func testTextViewSendsEvents() {
        let testObject = UITextView()
        let eventStream = testObject.rxs.text
        
        var events: [String] = []
        _ = eventStream.subscribeNext { events.append($0) }
        
        testObject.text = "Major Tom"
        NSNotificationCenter.defaultCenter().postNotificationName(UITextViewTextDidChangeNotification, object: testObject)
        XCTAssertEqual(events, ["Major Tom"])
        
        testObject.text = "No Event"

        testObject.text = "Ground Control"
        NSNotificationCenter.defaultCenter().postNotificationName(UITextViewTextDidChangeNotification, object: testObject)
        XCTAssertEqual(events, ["Major Tom", "Ground Control"])
    }
}