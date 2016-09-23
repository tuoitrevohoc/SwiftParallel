//
//  Promise.swift
//  SwiftState
//
//  Created by Tran Thien Khiem on 9/19/16.
//  Copyright © 2016 Tran Thien Khiem. All rights reserved.
//

import UIKit

/// the struct promise
public class Promise<T> {
    
    /// success callback
    typealias SuccessCallBack = ((T) -> ())
    
    /// the error callback
    typealias ErrorCallBack = ((Error) -> ())
    
    /// the dispatch queue
    var workItem: DispatchWorkItem!
    
    /// the callback function
    var successCallback: SuccessCallBack?
    
    /// error callback
    var errorCallBack: ErrorCallBack?
    
    /// the lock
    var lock: NSLock?
    
    /// get the result of the promise right await
    public var result: T? {
        var value: T?
        
        successCallback = {
            data in
            value = data
            self.lock?.unlock()
        }
        
        lock = NSLock()
        lock?.lock()
        lock?.lock()
        
        return value
    }
    
    ///
    /// initialize the promise with a handler
    /// - parameter handler: the handle of this promise
    public init(handler: @escaping (SuccessCallBack, ErrorCallBack) -> Void) {
        
        /// set the handler
        workItem = DispatchWorkItem(flags: .assignCurrentContext) {
            handler({
                data in
                self.successCallback?(data)
            }, {
                error in
                self.errorCallBack?(error)
            })
        }
        
        DispatchQueue.global(qos: .background).async(execute: workItem)
        
    }
    
    /// then function
    @discardableResult
    public func then(callback: @escaping (T) -> ()) -> Promise<T> {
        
        successCallback = {
            data in
            DispatchQueue.main.async {
                callback(data)
            }
        }

        return self
    }
    
    /// catch an error
    /// - parameter callback: the error handler
    @discardableResult
    public func onError(callback: @escaping (Error) -> ()) -> Promise<T> {
        errorCallBack = {
            error in
            DispatchQueue.main.async {
                callback(error)
            }
        }
        
        return self
    }
    
    

}
