import RxSugar
import XCTest

extension UISwitch: TestControl {}

class UISwitch_SugarTests: XCTestCase {
    func testSwitchSendsEvents() {
        let testObject = UISwitch()
        let eventStream = testObject.rxs.on
        
        var events: [Bool] = []
        _ = eventStream.subscribe(onNext: { events.append($0) })
        
        testObject.isOn = true
        testObject.fireControlEvents([.valueChanged])
        XCTAssertEqual(events, [true])
        
        testObject.isOn = false
        testObject.fireControlEvents([.valueChanged])
        XCTAssertEqual(events, [true, false])
        
        testObject.isOn = true
        testObject.fireControlEvents([.valueChanged])
        
        testObject.isOn = false
        testObject.fireControlEvents([.touchCancel])
        
        testObject.isOn = true
        testObject.fireControlEvents([.valueChanged])
        XCTAssertEqual(events, [true, false, true, true])
    }
    
    func testSwitchUpdatesValue() {
        let testObject = UISwitch()
        let observer = testObject.rxs.on
        
        observer.onNext(true)
        XCTAssertTrue(testObject.isOn)
        
        observer.onNext(false)
        XCTAssertFalse(testObject.isOn)
    }
}
