//
//  ViewController.swift
//  RX_NY_Times
//
//  Created by Mohammed Essam on 03/08/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    //MARK: UI
    lazy private var loader: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        return indicator
    }()
    
    public var isLoading = BehaviorRelay<Bool>(value: false)
    public let disposeBag = DisposeBag()
    
    //MARK: life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.drawMyView()
        self.manageObserver()
    }
    deinit {
        print("\(String(describing: self)) deinit")
    }

    //MARK: Draw
    private func drawMyView(){
        //Background
        self.view.backgroundColor = DesignSystem.appColor(.secondry)
        
        //draw SubViews
        self.view.addSubview(self.loader)
        self.loader.withConstraints(withWidth: DesignSystem.buttonHeight,
                                    withHeight: DesignSystem.buttonHeight,
                                    centerVertical: true, centerHorizontal: true)
    }
    //MARK: manage Observers
    private func manageObserver(){
        self.isLoading
            .asDriver()
            .drive(onNext: {[unowned self] in
                $0 ? self.loader.startAnimating():self.loader.stopAnimating()
                $0 ? self.view.bringSubviewToFront(self.loader):()
            }).disposed(by: disposeBag)
        
    }
}

