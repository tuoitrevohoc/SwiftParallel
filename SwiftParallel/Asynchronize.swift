//
//  Asynchronize.swift
//  SwiftParallel
//
//  Created by Tran Thien Khiem on 9/23/16.
//  Copyright © 2016 Tran Thien Khiem. All rights reserved.
//


/// run a closure asynchronously
///
/// - parameter handler: the closure to run
/// - returns: a promise
public func async<T>(_ handler: @escaping () -> T) -> Promise<T> {
    
    /// create a promise and accept
    return Promise<T>(handler: {
        (accept, reject) in
        let result = handler()
        accept(result)
    })
}


/// run a closure asynchronously
///
/// - parameter handler: the closure to run
/// - returns: a promise
public func async<T>(_ handler: @escaping () throws -> T) -> Promise<T> {
    
    /// create a promise and accept
    return Promise<T>(handler: {
        (accept, reject) in
        do {
            let result = try handler()
            accept(result)
        } catch let error {
            reject(error)
        }
    })
}
