import XCTest
import Foundation
import RxSwift
import RxSugar

class CombinePreviousTests: XCTestCase {
    func testCombinePreivousCombinesLatestTwoValues() {
        let input = Variable<Int>(42)
        let output = Variable<(Int, Int)>(0, 0)
        
        _ = output <~ input.asObservable().combinePrevious { $0 }
        
        input.onNext(11)
        XCTAssertEqual(output.value.0, 42)
        XCTAssertEqual(output.value.1, 11)
        
        input.onNext(1337)
        XCTAssertEqual(output.value.0, 11)
        XCTAssertEqual(output.value.1, 1337)
    }
}
