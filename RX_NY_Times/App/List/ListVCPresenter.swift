//
//  ListVCPresenter.swift
//  RX_NY_Times
//
//  Created by Mohammed Essam on 03/08/2022.
//  
//

import Foundation
import RxCocoa
import RxSwift

class ListVCPresenter: ListVCPresenterProtocol {

    // MARK: Properties
    let interactor: ListVCInteractorProtocol
    let router: ListVCRouterProtocol

    private var disposeBag = DisposeBag()

    // MARK: - ViewModelType

    struct Input {
        let viewDidLoad = PublishRelay<Void>()
    }

    struct Output {
        let isLoading = BehaviorRelay<Bool>(value: false)
        let list = BehaviorRelay<[Result]>(value: [])
    }

    let input = Input()
    let output = Output()

    // MARK: - Initialization

    init(interactor: ListVCInteractorProtocol,
         router: ListVCRouterProtocol) {
        self.interactor = interactor
        self.router = router
        print("\(String(describing: self)) init")
        self.managePresenting()
    }
    deinit {
        print("\(String(describing: self)) deinit")
    }

    // MARK: - Management

    func managePresenting(){
        let activityIndicator = ActivityIndicator()
    
        activityIndicator
            .asObservable()
            .bind(to: output.isLoading)
            .disposed(by: disposeBag)

        input.viewDidLoad
            .asObservable()
            .flatMapLatest {[unowned self] in
                self.interactor.fetchData()
                    .trackActivity(activityIndicator)
                    .do(onError: {_ in
//                        Alert().present(message: $0.errorMessage)
                    })
                    .catch { _ in Observable.never() }
            }
            .bind(to: output.list)
            .disposed(by: disposeBag)

    }

}
