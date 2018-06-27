//
//  ReactiveCocoaExtension.swift
//  NBHHDemo
//
//  Created by jktz on 2018/6/27.
//  Copyright © 2018年 jktz. All rights reserved.
//

import Result
import ReactiveCocoa
import ReactiveSwift

typealias ButtonAction = CocoaAction<UIButton>

extension SignalProducer where Error == NoError {
    
    @discardableResult
    func startWithValues(_ action: @escaping (Value) -> Void) -> Disposable {
        return start(Signal.Observer(value: action))
    }
}

extension CocoaAction{
    
    public convenience init<Output, Error>(_ action: Action<Any?, Output, Error>) {
        self.init(action, input: nil)
    }
}
