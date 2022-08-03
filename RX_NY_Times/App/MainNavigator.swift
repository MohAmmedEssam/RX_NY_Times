//
//  MainNavigator.swift
//  RX_NY_Times
//
//  Created by Mohammed Essam on 03/08/2022.
//

import Foundation
import UIKit

class MainNavigator: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setupUI()
    }
    
    private func setupUI(){
        self.navigationBar.backgroundColor = DesignSystem.appColor(.primary)
        self.navigationBar.barTintColor = DesignSystem.appColor(.secondry)
        self.navigationBar.tintColor = DesignSystem.appColor(.secondry)
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:DesignSystem.appColor(.secondry)]
        
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000.0, vertical: 0.0), for: .default)
    }

}

