//
//  RootViewController.swift
//  CollectionViewLoadTest
//
//  Created by Sasha K on 10/20/17.
//  Copyright © 2017 Aliaksandr Kantsevoi. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    private let workController: ViewController
    private let layoutHelper: LayoutHelper

    init(workController: ViewController, layoutHelper: LayoutHelper) {
        self.workController = workController
        self.layoutHelper = layoutHelper
        super.init(nibName: nil, bundle: nil)

        layoutHelper.cellModels.subscribe { [weak workController] (cellModels) in
            DispatchQueue.main.async {
                guard let controller = workController else {return}
                controller.models = cellModels
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChildViewController(workController)
        self.view.addSubview(workController.view)
        self.view.setNeedsLayout()
        workController.didMove(toParentViewController: self)
    }

    override func viewDidLayoutSubviews() {
        let bounds = self.view.bounds
        workController.view.frame = bounds
        layoutHelper.width = bounds.width
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

