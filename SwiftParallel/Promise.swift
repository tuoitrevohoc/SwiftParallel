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
    
    /// the callback function
    var successCallback: SuccessCallBack?
    
    /// error callback
    var errorCallBack: ErrorCallBack?
    
    ///
    /// initialize the promise with a handler
    /// - parameter handler: the handle of this promise
    public init(handler: @escaping (SuccessCallBack, ErrorCallBack) -> Void) {
        
        /// set the handler
        DispatchQueue.global(qos: .background).async {
            handler({
                data in
                self.successCallback?(data)
            }, {
                error in
                self.errorCallBack?(error)
            })
        }
        
        
    }
    
    /// then function
    @discardableResult
    public func then(callback: @escaping (T) -> ()) -> Promise<T> {
        
        successCallback = {
            data in
            callback(data)
        }

        return self
    }
    
    /// catch an error
    /// - parameter callback: the error handler
    @discardableResult
    public func onError(callback: @escaping (Error) -> ()) -> Promise<T> {
        errorCallBack = callback
        
        return self
    }

}
