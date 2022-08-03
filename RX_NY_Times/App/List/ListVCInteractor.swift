//
//  ListVCInteractor.swift
//  RX_NY_Times
//
//  Created by Mohammed Essam on 03/08/2022.
//  
//

import Foundation
import RxSwift

class ListVCInteractor: ListVCInteractorProtocol {

    // MARK: - Initialization

    init(){
        print("\(String(describing: self)) init")
    }
    deinit {
        print("\(String(describing: self)) deinit")
    }

    // MARK: - Management

    func fetchData() -> Observable<[Result]> {
        let params = ["api-key":"CqM7B7cpRU6GtV2iI8mMD1Y8885RCkQ4"]
        let observable:Observable<MostPopularResponse?> = NetworkLayer(.mostPopular(params: params),
                                                                       supportWithOurModel: false).request()
        return observable.compactMap { $0?.results } //!=nil
    }

}
