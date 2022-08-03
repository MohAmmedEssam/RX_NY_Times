//
//  ListVCContract.swift
//  RX_NY_Times
//
//  Created by Mohammed Essam on 03/08/2022.
//  
//

import Foundation
import UIKit
import RxSwift

protocol ListVCViewProtocol {
    var presenter: ListVCPresenter { get }
}


protocol ListVCPresenterProtocol {
    var interactor: ListVCInteractorProtocol { get }
    var router: ListVCRouterProtocol { get }
}


protocol ListVCInteractorProtocol {
    func fetchData() -> Observable<[Result]> 
}


protocol ListVCRouterProtocol {
    func navDetails(model: Result)
}
