//
//  TestCellModel.swift
//  CollectionViewLoadTest
//
//  Created by Sasha K on 10/20/17.
//  Copyright © 2017 Aliaksandr Kantsevoi. All rights reserved.
//

import UIKit

private enum Constants {
    static let verticalPadding: CGFloat = 5
    static let interItemSpacing: CGFloat = 2
}

class TestCellModel {
    let textModel: LabelModel
    let likesModel: LabelModel
    var frame: CGRect

    static func zero() -> TestCellModel {
        return TestCellModel(textModel: LabelModel.zero(), likesModel: LabelModel.zero())
    }

    init(textModel: LabelModel, likesModel: LabelModel, frame: CGRect = CGRect.zero) {
        self.textModel = textModel
        self.likesModel = likesModel
        self.frame = frame
    }

    func layout(with maxSize: CGSize) {
        
        let likesMaxSize = CGSize(width: maxSize.width,
                               height: CGFloat.greatestFiniteMagnitude)
        likesModel.layout(with: likesMaxSize)
        
        
        let textWidthRestriction = maxSize.width - likesModel.frame.width - Constants.interItemSpacing
        
        let textMaxSize = CGSize(width: textWidthRestriction,
                              height: CGFloat.greatestFiniteMagnitude)
        textModel.layout(with: textMaxSize)
        
        textModel.frame.origin = CGPoint(x: 0, y: Constants.verticalPadding)
        likesModel.frame.origin = CGPoint(x: textWidthRestriction + Constants.interItemSpacing,
                                          y: Constants.verticalPadding)
        
        self.frame = CGRect(x: 0,
                            y: 0,
                            width: maxSize.width,
                            height: textModel.frame.height + Constants.verticalPadding * 2)
    }
}

func createCellModel(_ serviceModel: ServiceModel, width: CGFloat) -> TestCellModel {
    let model = TestCellModel(
        textModel: LabelModel(text: textAttributedString(serviceModel.postText)),
        likesModel: LabelModel(text: likesAttributedString(serviceModel.likes)))
    model.layout(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
    return model
}

func textAttributedString(_ text: String) -> NSAttributedString {
    return NSAttributedString(string: text,
                              attributes: [.font: UIFont.systemFont(ofSize: 18)])
}

func likesAttributedString(_ count: UInt) -> NSAttributedString {
    return NSAttributedString(string: "❤️\(count)",
        attributes: [.font: UIFont.systemFont(ofSize: 10)])
}
