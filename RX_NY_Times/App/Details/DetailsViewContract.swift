//
//  DetailsViewContract.swift
//  RX_NY_Times
//
//  Created by Mohammed Essam on 03/08/2022.
//  
//

import Foundation
import UIKit
import RxSwift

protocol DetailsViewViewProtocol {
    var presenter: DetailsViewPresenter { get }
}


protocol DetailsViewPresenterProtocol {
    var interactor: DetailsViewInteractorProtocol { get }
    var router: DetailsViewRouterProtocol { get }
}


protocol DetailsViewInteractorProtocol {

}


protocol DetailsViewRouterProtocol {
    var model: Result {get}

}
