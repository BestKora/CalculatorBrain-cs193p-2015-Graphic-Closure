//
//  CalculatorBrainTests.swift
//  CalculatorBrainTests
//
//  Created by Tatiana Kornilova on 2/5/15.
//  Copyright (c) 2015 Tatiana Kornilova. All rights reserved.
//

import UIKit
import XCTest

class CalculatorBrainTests: XCTestCase {
     private var brain = CalculatorBrain()
    
    func testPushOperandVariable() {
        XCTAssertNil(brain.pushOperand("x"))
        brain.setVariable ("x", value: 5.2)
        XCTAssertEqual(5.2, brain.pushOperand("x")!)
        XCTAssertEqual(10.4, brain.performOperation("+")!)
    }

    
    func testDescription() {
        // cos(10)
        brain = CalculatorBrain()
        XCTAssertEqual(brain.pushOperand(10)!, 10)
        XCTAssertTrue(brain.performOperation("cos")! - -0.839 < 0.1)
        XCTAssertEqual(brain.displayStack(), "10.0 cos")
        
        // 3 - 5
        brain = CalculatorBrain()
        XCTAssertEqual(brain.pushOperand(3)!, 3)
        XCTAssertEqual(brain.pushOperand(5)!, 5)
        XCTAssertEqual(brain.performOperation("−")!, -2)
        XCTAssertEqual(brain.description, "3 − 5")
        
        // 23.5
        brain = CalculatorBrain()
        XCTAssertEqual(brain.pushOperand(23.5)!, 23.5)
        XCTAssertEqual(brain.description, "23.5")
        
        // π
        brain = CalculatorBrain()
        XCTAssertEqual(brain.performOperation("π")!, M_PI)
        XCTAssertEqual(brain.description, "π")
        
        // x
        brain = CalculatorBrain()
        XCTAssertNil(brain.pushOperand("x"))
        XCTAssertEqual(brain.description, "x")
        
        // √(10) + 3
        brain = CalculatorBrain()
        XCTAssertEqual(brain.pushOperand(10)!, 10)
        XCTAssertTrue(brain.performOperation("√")! - 3.162 < 0.1)
        XCTAssertEqual(brain.pushOperand(3)!, 3)
        XCTAssertTrue(brain.performOperation("+")! - 6.162 < 0.1)
        XCTAssertEqual(brain.description, "√(10) + 3")
        
        // √(3 + 5)
        brain = CalculatorBrain()
        XCTAssertEqual(brain.pushOperand(3)!, 3)
        XCTAssertEqual(brain.pushOperand(5)!, 5)
        XCTAssertEqual(brain.performOperation("+")!, 8)
        XCTAssertTrue(brain.performOperation("√")! - 2.828 < 0.1)
        XCTAssertEqual(brain.description, "√(3 + 5)")
        
        // 3 + (5 + 4) -->  3 + 5 + 4
        brain = CalculatorBrain()
        XCTAssertEqual(brain.pushOperand(3)!, 3)
        XCTAssertEqual(brain.pushOperand(5)!, 5)
        XCTAssertEqual(brain.pushOperand(4)!, 4)
        XCTAssertEqual(brain.performOperation("+")!, 9)
        XCTAssertEqual(brain.performOperation("+")!, 12)
        XCTAssertEqual(brain.description, "3 + 5 + 4")
        
        // (3 + 5) * 6
        brain = CalculatorBrain()
        XCTAssertEqual(brain.pushOperand(3)!, 3)
        XCTAssertEqual(brain.pushOperand(5)!, 5)
        XCTAssertEqual(brain.performOperation("+")!, 8)
        XCTAssertEqual(brain.pushOperand(6)!, 6)
        XCTAssertEqual(brain.performOperation("×")!, 48)
        XCTAssertEqual(brain.description, "(3 + 5) × 6")


        // √(3 + √(5)) ÷ 6
        brain = CalculatorBrain()
        XCTAssertEqual(brain.pushOperand(3)!, 3)
        XCTAssertEqual(brain.pushOperand(5)!, 5)
        XCTAssertTrue(brain.performOperation("√")! - 2.236 < 0.1)
        XCTAssertTrue(brain.performOperation("+")! - 5.236 < 0.1)
        XCTAssertTrue(brain.performOperation("√")! - 2.288 < 0.1)
        XCTAssertEqual(brain.pushOperand(6)!, 6)
        XCTAssertTrue(brain.performOperation("÷")! - 0.381 < 0.1)
        XCTAssertEqual(brain.description, "√(3 + √(5)) ÷ 6")
        
        // ? + 3
        brain = CalculatorBrain()
        XCTAssertEqual(brain.pushOperand(3)!, 3)
        XCTAssertNil(brain.performOperation("+"))
        XCTAssertEqual(brain.description, "? + 3")
        
        // √(3 + 5), cos(π)
        brain = CalculatorBrain()
        XCTAssertEqual(brain.pushOperand(3)!, 3)
        XCTAssertEqual(brain.pushOperand(5)!, 5)
        XCTAssertEqual(brain.performOperation("+")!, 8)
        XCTAssertTrue(brain.performOperation("√")! - 2.828 < 0.1)
        XCTAssertEqual(brain.performOperation("π")!, M_PI)
        XCTAssertEqual(brain.performOperation("cos")!, -1)
        XCTAssertEqual(brain.description, "√(3 + 5), cos(π)")
        
        // 3 * (5 + 4)
        brain = CalculatorBrain()
        XCTAssertEqual(brain.pushOperand(3)!, 3)
        XCTAssertEqual(brain.pushOperand(5)!, 5)
        XCTAssertEqual(brain.pushOperand(4)!, 4)
        XCTAssertEqual(brain.performOperation("+")!, 9)
        XCTAssertEqual(brain.performOperation("×")!, 27)
        XCTAssertEqual(brain.description, "3 × (5 + 4)")
        
        // 3 - (5 + 4) commutative test
        brain = CalculatorBrain()
        XCTAssertEqual(brain.pushOperand(3)!, 3)
        XCTAssertEqual(brain.pushOperand(5)!, 5)
        XCTAssertEqual(brain.pushOperand(4)!, 4)
        XCTAssertEqual(brain.performOperation("+")!, 9)
        XCTAssertEqual(brain.performOperation("−")!, -6)
        XCTAssertEqual(brain.description, "3 − (5 + 4)")
        
        // 3 / (5 × 4) commutative test
        brain = CalculatorBrain()
        XCTAssertEqual(brain.pushOperand(3)!, 3)
        XCTAssertEqual(brain.pushOperand(5)!, 5)
        XCTAssertEqual(brain.pushOperand(4)!, 4)
        XCTAssertEqual(brain.performOperation("×")!, 20)
        XCTAssertEqual(brain.performOperation("÷")!, 0.15)
        XCTAssertEqual(brain.description, "3 ÷ (5 × 4)")
        
       // (3 + 5) + (7 + 8)
        brain = CalculatorBrain()
        XCTAssertEqual(brain.pushOperand(3)!, 3)
        XCTAssertEqual(brain.pushOperand(5)!, 5)
        XCTAssertEqual(brain.performOperation("+")!, 8)
        XCTAssertEqual(brain.pushOperand(7)!, 7)
        XCTAssertEqual(brain.pushOperand(8)!, 8)
        XCTAssertEqual(brain.performOperation("+")!, 15)
        XCTAssertTrue(brain.performOperation("÷")! - 0.53333 < 0.1)
        XCTAssertEqual(brain.description, "(3 + 5) ÷ (7 + 8)")
        
        // 3 - 5 - (7 - 8) commutative test
        brain = CalculatorBrain()
        XCTAssertEqual(brain.pushOperand(3)!, 3)
        XCTAssertEqual(brain.pushOperand(5)!, 5)
        XCTAssertEqual(brain.performOperation("−")!, -2)
        XCTAssertEqual(brain.pushOperand(7)!, 7)
        XCTAssertEqual(brain.pushOperand(8)!, 8)
        XCTAssertEqual(brain.performOperation("−")!, -1)
        XCTAssertEqual(brain.performOperation("−")!, -1)
        XCTAssertEqual(brain.description, "3 − 5 − (7 − 8)")

        
        // √((3 + 5) × (7 + 8))
        brain = CalculatorBrain()
        XCTAssertEqual(brain.pushOperand(3)!, 3)
        XCTAssertEqual(brain.pushOperand(5)!, 5)
        XCTAssertEqual(brain.performOperation("+")!, 8)
        XCTAssertEqual(brain.pushOperand(7)!, 7)
        XCTAssertEqual(brain.pushOperand(8)!, 8)
        XCTAssertEqual(brain.performOperation("+")!, 15)
        XCTAssertEqual(brain.performOperation("×")!, 120)
        XCTAssertTrue(brain.performOperation("√")! - 10.9544 < 0.1)
        XCTAssertEqual(brain.description, "√((3 + 5) × (7 + 8))")

    }
    
    func testSharedInstance() {
        let instance = CalculatorFormatter.sharedInstance
        XCTAssertNotNil(instance, "")
    }
    
    func testSharedInstance_Unique() {
        let instance1 = CalculatorFormatter()
        let instance2 = CalculatorFormatter.sharedInstance
        XCTAssertFalse(instance1 === instance2)
    }
    
    func testSharedInstance_Twice() {
        let instance1 = CalculatorFormatter.sharedInstance
        let instance2 = CalculatorFormatter.sharedInstance
        XCTAssertTrue(instance1 === instance2)
    }
    func testSharedInstance_ThreadSafety() {
        var instance1 : CalculatorFormatter!
        var instance2 : CalculatorFormatter!
        
        let expectation1 = expectationWithDescription("Instance 1")
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            instance1 = CalculatorFormatter.sharedInstance
            expectation1.fulfill()
        }
        let expectation2 = expectationWithDescription("Instance 2")
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            instance2 = CalculatorFormatter.sharedInstance
            expectation2.fulfill()
        }
        
        waitForExpectationsWithTimeout(1.0) { (_) in
            XCTAssertTrue(instance1 === instance2)
        }
    }
}
