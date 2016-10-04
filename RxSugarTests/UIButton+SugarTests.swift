import RxSugar
import XCTest

extension UIButton: TestControl {}

class UIButton_SugarTests: XCTestCase {
    func testButtonSendsEvents() {
        let testObject = UIButton()
        let eventStream = testObject.rxs.tap
        
        var events: [String] = []
        _ = eventStream.subscribe(onNext: { events.append("tap") })
        
        testObject.fireControlEvents([testObject.rxs.primaryControlEvent()])
        XCTAssertEqual(events, ["tap"])
        
        testObject.fireControlEvents([.touchDown])
        XCTAssertEqual(events, ["tap"])
        
        testObject.fireControlEvents([testObject.rxs.primaryControlEvent()])
        XCTAssertEqual(events, ["tap", "tap"])
    }
}
