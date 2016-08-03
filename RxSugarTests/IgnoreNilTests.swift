import XCTest
import Foundation
import RxSwift
import RxSugar

class IgnoreNilTests: XCTestCase {
    func testIgnoreNilSkipsNilEvents() {
        let input = Variable<Int?>(2)
        let output = Variable<Int>(0)
        
        _ = output <~ input.asObservable().ignoreNil()

        XCTAssertEqual(output.value, 2)

        input.value = nil
        XCTAssertEqual(output.value, 2)

        input.value = 3
        XCTAssertEqual(output.value, 3)
    }
    
    func testToOptionalWrapsValues() {
        let input = Variable<Int>(0)
        let output = Variable<Int?>(0)
        
        _ = output <~ input.asObservable().toOptional()
        
        input.value = 2
        XCTAssertEqual(output.value, .some(2))
        XCTAssertNotNil(output.value.optional)
    }
}
