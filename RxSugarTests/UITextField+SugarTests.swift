import UIKit
import RxSugar
import XCTest

extension UITextField: TestControl {}

class UITextField_SugarTests: XCTestCase {
    func testTextFieldSendsEvents() {
        let testObject = UITextField()
        let eventStream = testObject.rxs.text

        var events: [String] = []
        _ = eventStream.subscribeNext { events.append($0) }

        testObject.text = "Major Tom"
        testObject.fireControlEvents([.EditingChanged])
        XCTAssertEqual(events, ["Major Tom"])

        testObject.text = "No Event"
        testObject.fireControlEvents([.TouchDown])
        XCTAssertEqual(events, ["Major Tom"])
        
        testObject.text = "Ground Control"
        testObject.fireControlEvents([.EditingChanged])
        XCTAssertEqual(events, ["Major Tom", "Ground Control"])
    }
}