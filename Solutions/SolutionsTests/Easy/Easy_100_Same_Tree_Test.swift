//
//  Easy_100_Same_Tree_Test.swift
//  Solutions
//
//  Created by Di Wu on 12/11/15.
//  Copyright © 2015 diwu. All rights reserved.
//

import XCTest

class Easy_100_Same_Tree_Test: XCTestCase, SolutionsTestCase {
    private typealias Node_Swift = Easy_100_Same_Tree.Node
    private typealias Node_ObjC = ObjC_Easy_100_Same_Tree_Node
    private func convertArrayToTree_swift(_ arr: [Int]) -> Node_Swift {
        let root: Node_Swift = Node_Swift.init(value: arr[0], left: nil, right: nil)
        var fifoQueue: [Node_Swift] = [root]
        var i = 1
        while i < arr.count {
            let node: Node_Swift = fifoQueue.removeFirst()
            if arr[i] == Int.min {
                node.left = nil
            } else {
                node.left = Node_Swift.init(value: arr[i], left: nil, right: nil)
                fifoQueue.append(node.left!)
            }
            if arr[i+1] == Int.min {
                node.right = nil
            } else {
                node.right = Node_Swift.init(value: arr[i+1], left: nil, right: nil)
                fifoQueue.append(node.right!)
            }
            i += 2
        }
        return root
    }
    private func convertArrayToTree_objc(_ arr: [Int]) -> Node_ObjC {
        let root: Node_ObjC = Node_ObjC.init(value: arr[0], left: nil, right: nil)
        var fifoQueue: [Node_ObjC] = [root]
        var i = 1
        while i < arr.count {
            let node: Node_ObjC = fifoQueue.removeFirst()
            if arr[i] == Int.min {
                node.left = nil
            } else {
                node.left = Node_ObjC.init(value: arr[i], left: nil, right: nil)
                fifoQueue.append(node.left!)
            }
            if arr[i+1] == Int.min {
                node.right = nil
            } else {
                node.right = Node_ObjC.init(value: arr[i+1], left: nil, right: nil)
                fifoQueue.append(node.right!)
            }
            i += 2
        }
        return root
    }
    func test_001() {
        let input: [[Int]] = [
            [4, 2, 6, 1, 3, 5, 7],
            [4, 2, 6, 1, 3, 5, 7],
        ]
        let expected: Bool = true
        asyncHelper(input: input, expected: expected)
    }
    func test_002() {
        let input: [[Int]] = [
            [4, 2, 6, 1, 3, Int.min, 7],
            [4, 2, 6, 1, 3, 7, Int.min],
        ]
        let expected: Bool = false
        asyncHelper(input: input, expected: expected)
    }
    func test_003() {
        let input: [[Int]] = [
            [4, 2, 6],
            [4, 2, 6, 1, 3, 5, 7],
        ]
        let expected: Bool = false
        asyncHelper(input: input, expected: expected)
    }
    func test_004() {
        let input: [[Int]] = [
            [4, 2, 6, 1, 3, 5, 7],
            [4, 2, 6, 1, Int.min],
        ]
        let expected: Bool = false
        asyncHelper(input: input, expected: expected)
    }
    func test_005() {
        let input: [[Int]] = [
            [4],
            [4],
        ]
        let expected: Bool = true
        asyncHelper(input: input, expected: expected)
    }
    private func asyncHelper(input: [[Int]], expected: Bool) {
        weak var expectation: XCTestExpectation? = self.expectation(description:timeOutName())
        serialQueue().async(execute: { () -> Void in
            let result_swift: Bool = Easy_100_Same_Tree.isSameTree(p: self.convertArrayToTree_swift(input[0]), q: self.convertArrayToTree_swift(input[1]))
            let result_objc: Bool = ObjC_Easy_100_Same_Tree.isSameTree( withP: self.convertArrayToTree_objc(input[0]), q: self.convertArrayToTree_objc(input[1]))
            assertHelper(expected == result_swift, problemName:self.problemName(), input: input, resultValue: result_swift, expectedValue: expected)
            assertHelper(expected == result_objc, problemName:self.problemName(), input: input, resultValue: result_objc, expectedValue: expected)
            if let unwrapped = expectation {
                unwrapped.fulfill()
            }
        })
        waitForExpectations(timeout:timeOut()) { (error: Error?) -> Void in
            if error != nil {
                assertHelper(false, problemName:self.problemName(), input: input, resultValue:self.timeOutName(), expectedValue: expected)
            }
        }
    }
}
