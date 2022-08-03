//
//  ListVCRouter.swift
//  RX_NY_Times
//
//  Created by Mohammed Essam on 03/08/2022.
//  
//

import Foundation
import UIKit

class ListVCRouter: ListVCRouterProtocol {
    // MARK: Properties

    // MARK: - Initialization

    init() {
        print("\(String(describing: self)) init")
    }
    deinit {
        print("\(String(describing: self)) deinit")
    }

    // MARK: - Creating the Module

    func createModule() -> UIViewController {
        let interactor = ListVCInteractor()
        let presenter = ListVCPresenter(interactor: interactor, router: self)
        let viewController = ListVCViewController(presenter: presenter)

        return viewController
    }
    
    func navDetails(model: Result){
        let router = DetailsViewRouter(model: model).createModule()
        GlobalObjects.mainNavigator.pushViewController(router, animated: true)
    }
}
