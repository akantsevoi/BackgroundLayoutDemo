//
//  TestService.swift
//  CollectionViewLoadTest
//
//  Created by Sasha K on 10/20/17.
//  Copyright © 2017 Aliaksandr Kantsevoi. All rights reserved.
//

import Foundation

struct ServiceModel {
    let postText: String
    let likes: UInt
}

class TestService {
    let signal: Signal<[ServiceModel]> = Signal<[ServiceModel]>()
    var timer: DispatchSourceTimer

    init() {
        timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global(qos: .background))
        timer.schedule(deadline: .now() + 3, repeating: .seconds(1))
        timer.setEventHandler(handler: DispatchWorkItem(block: { [weak self] in
            guard let `self` = self else { return }
            let newModels = createRandomNumberOfServiceResponse()
            self.signal.update(newValue: newModels)
        }))
        timer.resume()
    }

    func pauseService() {
        timer.cancel()
    }
}


private func createRandomNumberOfServiceResponse() -> [ServiceModel] {
    let random = arc4random_uniform(100)

    var models = [ServiceModel]()
    models.reserveCapacity(Int(random))

    let dateString = Date().description

    for i in 0...random {
        models.append(ServiceModel(
            postText: loremIpsumText(index: Int(i), base: dateString),
            likes: UInt(random % (10 + i))))
    }

    return models
}

private func loremIpsumText(index: Int, base: String) -> String {
    let string = String(repeating: "LoremIpsum text ", count: index % 15) + base
    return string
}
