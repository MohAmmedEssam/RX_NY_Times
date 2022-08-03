//
//  label.swift
//  RX_NY_Times
//
//  Created by Mohammed Essam on 03/08/2022.
//

import Foundation
import UIKit

extension UILabel{
    func prepare(textColor: DesignSystem.sysColor,
                 font: DesignSystem.sysFont,
                 textAlignment: NSTextAlignment = .natural,
                 numberOfLines:Int = 0){
        
        self.textColor = DesignSystem.appColor(textColor)
        self.font = DesignSystem.appFont(font)
        self.textAlignment = ((textAlignment == .natural) ? .natural:textAlignment)
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = numberOfLines
    }
}
