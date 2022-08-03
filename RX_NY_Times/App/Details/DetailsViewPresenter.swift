//
//  DetailsViewPresenter.swift
//  RX_NY_Times
//
//  Created by Mohammed Essam on 03/08/2022.
//  
//

import Foundation
import RxCocoa
import RxSwift

class DetailsViewPresenter: DetailsViewPresenterProtocol {

    // MARK: Properties
    let interactor: DetailsViewInteractorProtocol
    let router: DetailsViewRouterProtocol

    private var disposeBag = DisposeBag()

    // MARK: - ViewModelType

    struct Input {

    }

    struct Output {
        let model = BehaviorRelay<Result?>(value: nil)
    }

    let input = Input()
    let output = Output()

    // MARK: - Initialization

    init(interactor: DetailsViewInteractorProtocol,
         router: DetailsViewRouterProtocol) {
        self.interactor = interactor
        self.router = router
        self.output.model.accept(router.model)
        print("\(String(describing: self)) init")
        self.managePresenting()
    }
    deinit {
        print("\(String(describing: self)) deinit")
    }

    // MARK: - Management

    func managePresenting(){

    }

}
