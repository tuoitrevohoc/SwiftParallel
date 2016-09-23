//
//  PromiseTests.swift
//  SwiftParallel
//
//  Created by Tran Thien Khiem on 9/19/16.
//  Copyright © 2016 Tran Thien Khiem. All rights reserved.
//

import XCTest
import SwiftParallel

class PromiseTests: XCTestCase {
    
    ///
    /// some basic error type
    enum BasicError: Error {
        case NotOK
    }
    
    /// test creating a promise
    func testPromiseAccept() {
        let resultReturned = expectation(description: "Promise should finished")
        
        /// promise with handler
        Promise<String>(handler: {
            (accept, reject) in
            accept("Hello")
        }).then(callback: {
            data in
            print("data")
            
            resultReturned.fulfill()
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    /// test creating a promise
    func testPromiseError() {
        let errorHappened = expectation(description: "Promise should fire errors")
        
        /// promise with handler
        Promise<String>(handler: {
            (accept, reject) in
            reject(BasicError.NotOK)
        }).then(callback: {
            data in
            print("data")
        }).onError(callback: {
            error in
            print("Error")
            errorHappened.fulfill()
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    /// test creating a promise
    func testGetResult() {
        
        /// promise with handler
        let result = Promise<String>(handler: {
            (accept, reject) in
            accept("Hello World!")
        }).result
        
        XCTAssertEqual("Hello World!", result)
    }

    
}
