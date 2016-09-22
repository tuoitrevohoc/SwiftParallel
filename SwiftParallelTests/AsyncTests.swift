//
//  AsyncTests.swift
//  SwiftParallel
//
//  Created by Tran Thien Khiem on 9/23/16.
//  Copyright © 2016 Tran Thien Khiem. All rights reserved.
//

import XCTest
import SwiftParallel

/// asynchronous tests
class AsyncTests: XCTestCase {
    
    ///
    /// some basic error type
    enum BasicError: Error {
        case NotOK
    }
    
    /// hello world
    func testCallingAsync() {
        
        let resultReturned = expectation(description: "Promise should finished")
        
        async {
            return "Hello World"
        }.then(callback: {
            data in
            resultReturned.fulfill()
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    /// test runing the close synchronously and throws error
    func testCallingAsyncError() {
        let errorHappened = expectation(description: "Promise should fire errors")
        
        /// promise with handler
        async {
            throw BasicError.NotOK
        }.then(callback: {
            data in
            print("data")
        }).onError(callback: {
            error in
            print("Error")
            errorHappened.fulfill()
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
}
