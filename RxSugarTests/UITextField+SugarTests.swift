import UIKit
import RxSugar
import XCTest

extension UITextField: TestControl {}

class UITextField_SugarTests: XCTestCase {
    func testTextFieldSendsEvents() {
        let testObject = UITextField()
        let eventStream = testObject.rxs.text

        var events: [String] = []
        _ = eventStream.subscribe(onNext: { events.append($0) })

        testObject.text = "Major Tom"
        testObject.fireControlEvents([.editingChanged])
        XCTAssertEqual(events, ["Major Tom"])

        testObject.text = "No Event"
        testObject.fireControlEvents([.touchDown])
        XCTAssertEqual(events, ["Major Tom"])
        
        testObject.text = "Ground Control"
        testObject.fireControlEvents([.editingChanged])
        XCTAssertEqual(events, ["Major Tom", "Ground Control"])
        
        testObject.text = ""
        testObject.fireControlEvents([.editingDidEnd])
        XCTAssertEqual(events, ["Major Tom", "Ground Control", ""])
    }
    
    func testTextFieldUpdatesText() {
        let testObject = UITextField()
        let observer = testObject.rxs.text
        
        observer.onNext("Major Tom")
        XCTAssertEqual(testObject.text, "Major Tom")
        
        observer.onNext("Ground Control")
        XCTAssertEqual(testObject.text, "Ground Control")
    }
    
    func testTextFieldSendsAttributedTextEvents() {
        let testObject = UITextField()
        let eventStream = testObject.rxs.attributedText
        
        var events: [String] = []
        _ = eventStream.subscribe(onNext: { events.append($0.string) })
        
        testObject.text = "Major Tom"
        testObject.fireControlEvents([.editingChanged])
        XCTAssertEqual(events, ["Major Tom"])
        
        testObject.text = "No Event"
        testObject.fireControlEvents([.valueChanged])
        
        testObject.text = "Ground Control"
        testObject.fireControlEvents([.editingChanged])
        XCTAssertEqual(events, ["Major Tom", "Ground Control"])
        
        testObject.text = ""
        testObject.fireControlEvents([.editingDidEnd])
        XCTAssertEqual(events, ["Major Tom", "Ground Control", ""])
    }
    
    func testTextFieldUpdatesAttributedText() {
        let testObject = UITextField()
        let observer = testObject.rxs.attributedText
        
        let attributedStringOne = NSAttributedString(string: "Major Tom", attributes: ["TestAttribute" : "Value"])
        
        observer.onNext(attributedStringOne)
        XCTAssertEqual(testObject.attributedText?.string, attributedStringOne.string)
        XCTAssertEqual(testObject.attributedText?.attribute("TestAttribute", at: 0, effectiveRange: nil) as? String, "Value")
        
        let attributedStringTwo = NSAttributedString(string: "Ground Control", attributes: [NSForegroundColorAttributeName: UIColor.red])
        
        observer.onNext(attributedStringTwo)
        XCTAssertEqual(testObject.attributedText?.string, attributedStringTwo.string)
    }
}
