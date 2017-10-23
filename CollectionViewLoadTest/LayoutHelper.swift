//
//  LayoutHelper.swift
//  CollectionViewLoadTest
//
//  Created by Sasha K on 10/20/17.
//  Copyright © 2017 Aliaksandr Kantsevoi. All rights reserved.
//

import UIKit

class LayoutHelper {
    var width: CGFloat {
        didSet {
            if approximatelyEqual(cgFloat1: width, cgFloat2: oldValue, accuracy: 0.1) {
                recalculateLayout(with: width)
            }
        }
    }
    let cellModels: MutableProperty<[TestCellModel]> = MutableProperty<[TestCellModel]>([])
    private let workQueue = DispatchQueue(label: "com.LayoutHelper.workQueue")

    init(serviceModels: Signal<[ServiceModel]>, width: CGFloat = 0.0) {
        self.width = width

        self.workQueue.async { [weak self] in
            serviceModels.subscribe { (newModels) in
                guard let `self` = self else {return}
                let currentWidth = self.width
                let models = self.cellModels.value + newModels.map({createCellModel($0, width:currentWidth)})
                self.cellModels.update(newValue: models)
            }
        }
    }

    func recalculateLayout(with width: CGFloat) {
        self.workQueue.async { [weak self] in
            guard let `self` = self else {return}
            let models = self.cellModels.value
            let maxModelSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
            models.forEach({$0.layout(with: maxModelSize)})
            self.cellModels.update(newValue: models)
        }
    }
}

func approximatelyEqual(cgFloat1: CGFloat, cgFloat2: CGFloat, accuracy: CGFloat) -> Bool {
    return (cgFloat1 + accuracy > cgFloat2) && (cgFloat1 - accuracy < cgFloat2)
}
