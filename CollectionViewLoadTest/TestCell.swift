//
//  TestCell.swift
//  CollectionViewLoadTest
//
//  Created by Sasha K on 10/20/17.
//  Copyright © 2017 Aliaksandr Kantsevoi. All rights reserved.
//

import UIKit

class TestCell: UICollectionViewCell {

    private let textLabel: UILabel = UILabel()
    private let likesLabel: UILabel = UILabel()
    private var model: TestCellModel = TestCellModel.zero()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textLabel)
        addSubview(likesLabel)
        style()
    }
    
    private func style() {
        textLabel.numberOfLines = 0
        backgroundColor = UIColor.white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func applyModel(_ model: TestCellModel) {
        self.model = model
        setNeedsLayout()
    }

    override func layoutSubviews() {
        textLabel.applyModel(self.model.textModel)
        likesLabel.applyModel(self.model.likesModel)
    }
}
