//
//  DetailsViewRouter.swift
//  RX_NY_Times
//
//  Created by Mohammed Essam on 03/08/2022.
//  
//

import Foundation
import UIKit

class DetailsViewRouter: DetailsViewRouterProtocol {
    // MARK: - Properties
    var model: Result
    // MARK: - Initialization

    init(model: Result) {
        self.model = model
        print("\(String(describing: self)) init")
    }
    deinit {
        print("\(String(describing: self)) deinit")
    }

    // MARK: - Creating the Module

    func createModule() -> UIViewController {
        let interactor = DetailsViewInteractor()
        let presenter = DetailsViewPresenter(interactor: interactor, router: self)
        let viewController = DetailsViewViewController(presenter: presenter)

        return viewController
    }
}
