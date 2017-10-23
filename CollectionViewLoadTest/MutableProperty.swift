//
//  MutableProperty.swift
//  CollectionViewLoadTest
//
//  Created by Sasha K on 10/20/17.
//  Copyright © 2017 Aliaksandr Kantsevoi. All rights reserved.
//

import Foundation

class MutableProperty<T>: Signal<T> {
    private(set) var value: T

    init(_ value: T) {
        self.value = value
    }

    override func update(newValue: T) {
        self.value = newValue
        super.update(newValue: newValue)
    }

    override func subscribe(callBack: @escaping (T) -> ()) {
        callBack(self.value)
        super.subscribe(callBack: callBack)
    }
}

class Signal<T> {
    typealias Subscriber = (T) -> ()

    private var subscribers: [Subscriber] = []

    func update(newValue: T) {
        subscribers.forEach{ $0(newValue) }
    }

    func subscribe(callBack: @escaping Subscriber) {
        subscribers.append(callBack)
    }
}
