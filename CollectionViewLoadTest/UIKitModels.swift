//
//  UIKitModels.swift
//  CollectionViewLoadTest
//
//  Created by Sasha K on 10/20/17.
//  Copyright © 2017 Aliaksandr Kantsevoi. All rights reserved.
//

import UIKit

class LabelModel {
    var text: NSAttributedString
    var frame: CGRect

    static func zero() -> LabelModel{
        return LabelModel(text: NSAttributedString(), frame: CGRect.zero)
    }

    init(text: NSAttributedString, frame: CGRect = CGRect.zero) {
        self.text = text
        self.frame = frame
    }

    func layout(with maxSize: CGSize) {
        let textContainer = NSTextContainer(size: maxSize)
        textContainer.maximumNumberOfLines = 0
        textContainer.lineFragmentPadding = 0
        let textStorage = NSTextStorage(attributedString: self.text)
        
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)
        
        textStorage.addLayoutManager(layoutManager)
        
        self.frame = CGRect(origin: CGPoint(x: 0, y: 0),
                            size: layoutManager.usedRect(for: textContainer).size)
    }
}

extension UILabel {
    func applyModel(_ model: LabelModel) {
        self.attributedText = model.text
        self.frame = model.frame
    }
}
