import RxSugar
import XCTest

extension UIButton: TestControl {}

class UIButton_SugarTests: XCTestCase {
    func testButtonSendsEvents() {
        let testObject = UIButton()
        let eventStream = testObject.rxs.tap
        
        var events: [String] = []
        _ = eventStream.subscribeNext { events.append("tap") }
        
        testObject.fireControlEvents([.TouchUpInside])
        XCTAssertEqual(events, ["tap"])
        
        testObject.fireControlEvents([.TouchDown])
        XCTAssertEqual(events, ["tap"])
        
        testObject.fireControlEvents([.TouchUpInside])
        XCTAssertEqual(events, ["tap", "tap"])
    }
}