import UIKit
import RxSugar
import XCTest

class UILabel_SugarTests: XCTestCase {
	
	func testLabelUpdatesText() {
		let testObject = UILabel()
		let observer = testObject.rxs.text
		
		observer.onNext("Major Tom")
		XCTAssertEqual(testObject.text, "Major Tom")
		
		observer.onNext("Ground Control")
		XCTAssertEqual(testObject.text, "Ground Control")
	}
	
	func testLabelUpdatesAttributedText() {
		let testObject = UILabel()
		let observer = testObject.rxs.attributedText
		
		let attributedStringOne = NSAttributedString(string: "Major Tom", attributes: ["TestAttribute" : "Value"])
		
		observer.onNext(attributedStringOne)
		XCTAssertEqual(testObject.attributedText!.string, attributedStringOne.string)
		XCTAssertEqual(testObject.attributedText!.attribute("TestAttribute", at: 0, effectiveRange: nil) as? String, "Value")
		
		let attributedStringTwo = NSAttributedString(string: "Ground Control", attributes: [NSForegroundColorAttributeName: UIColor.red])
		
		observer.onNext(attributedStringTwo)
		XCTAssertEqual(testObject.attributedText!.string, attributedStringTwo.string)
	}
}
