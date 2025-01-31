//
//  Number Formatting Tests.swift
//  MIDIKit • https://github.com/orchetect/MIDIKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

#if shouldTestCurrentPlatform

import XCTest
import MIDIKitCore

final class NumberFormatting_Tests: XCTestCase {
    func testRoundedDecimalPlaces_Default() {
        XCTAssertEqual((1.126).rounded(decimalPlaces: 4), 1.126)
        XCTAssertEqual((1.126).rounded(decimalPlaces: 3), 1.126)
        XCTAssertEqual((1.126).rounded(decimalPlaces: 2), 1.13)
        XCTAssertEqual((1.126).rounded(decimalPlaces: 1), 1.1)
        XCTAssertEqual((1.126).rounded(decimalPlaces: 0), 1.0)
        XCTAssertEqual((1.126).rounded(decimalPlaces: -1), 1.0)
    }
}

#endif
