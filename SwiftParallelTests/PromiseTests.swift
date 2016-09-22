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
    
    
    /// test creating a promise
    func testCreatePromise() {
        
        /// promise with handler
        Promise<String>(handler: {
            (accept, reject) in
            accept("Hello")
        }).then(callback: {
            data in
            print("data")
        })
    }

    
}
