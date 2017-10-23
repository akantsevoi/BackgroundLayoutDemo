//
//  ViewController.swift
//  CollectionViewLoadTest
//
//  Created by Sasha K on 10/14/17.
//  Copyright © 2017 Aliaksandr Kantsevoi. All rights reserved.
//

import UIKit

private let reuseIdentifier = "reuseIdentifier"

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let collectionView = UICollectionView(
        frame: CGRect.zero,
        collectionViewLayout: UICollectionViewFlowLayout())

    var models: [TestCellModel] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.register(
            TestCell.self,
            forCellWithReuseIdentifier: reuseIdentifier)
        view.addSubview(collectionView)

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.view.backgroundColor = UIColor.white
    }

    override func viewDidLayoutSubviews() {
        self.collectionView.frame = self.view.bounds
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TestCell

        cell.applyModel(models[indexPath.item])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return models[indexPath.item].frame.size
    }
}
