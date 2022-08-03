//
//  RxLifeCycle.swift
//  RX_NY_Times
//
//  Created by Mohammed Essam on 03/08/2022.
//

import Foundation
import RxSwift
import RxCocoa

public extension Reactive where Base: UIViewController {
    var viewDidLoad: ControlEvent<Void> {
      let source = self.methodInvoked(#selector(Base.viewDidLoad)).map { _ in }
      return ControlEvent(events: source)
    }
    var viewWillAppear: ControlEvent<Void> {
      let source = self.methodInvoked(#selector(Base.viewWillAppear)).map { _ in }
      return ControlEvent(events: source)
    }
    var viewDidAppear: ControlEvent<Void> {
      let source = self.methodInvoked(#selector(Base.viewDidAppear)).map { _ in }
      return ControlEvent(events: source)
    }
    var viewDidDisappear: ControlEvent<Void> {
      let source = self.methodInvoked(#selector(Base.viewDidDisappear)).map { _ in }
      return ControlEvent(events: source)
    }
}
