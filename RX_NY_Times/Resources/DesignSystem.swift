//
//  DesignSystem.swift
//  RX_NY_Times
//
//  Created by Mohammed Essam on 03/08/2022.
//

/* Documentation
 DesignSystem static class contains app colors and fonts for clean coding
    just use it like this:-
        DesignSystem.appColor(.secondry)
        DesignSystem.appFont(.normal)
*/

import Foundation
import UIKit

//MARK: - Common constraints
class DesignSystem{
    //space
    static let verticalSpace = (UIScreen.main.bounds.height * 0.02)
    static let horizontalSpace = (UIScreen.main.bounds.width * 0.04)

    //button
    static let buttonHeight = (UIScreen.main.bounds.height * 0.06)
    static let buttonWidth = (UIScreen.main.bounds.width * 0.34)

    //SafeArea
    static let bottomGuide = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
    static let topGuide = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0

}
//MARK: - Colors
extension DesignSystem{
    
    enum sysColor: String {
        case secondry = "#ffffff"
        case primary = "#2530be"
        
        case success = "#25be45"
        case error = "#Be3025"
        
        case label = "#000000"
        case secondarylabel = "#7E7E83"

        var value:UIColor{
            return self.rawValue.hexToColor
        }
    }
    static func appColor(_ color:sysColor)->UIColor{
        return color.value
    }
}

//MARK: - Fonts
extension DesignSystem{
    enum sysFont {
        case h1
        case h2
        case h3
        case h4
        case h5
        case h6
        case h7
        case h8

        var value:UIFont{
            let devicePercentage:CGFloat = (UIDevice.current.userInterfaceIdiom == .phone) ? 1:2
            switch self {
            case .h1:
                return .systemFont(ofSize: 48*devicePercentage,weight: .bold)
            case .h2:
                return .systemFont(ofSize: 30*devicePercentage,weight: .bold)
            case .h3:
                return .systemFont(ofSize: 24*devicePercentage,weight: .semibold)
            case .h4:
                return .systemFont(ofSize: 20*devicePercentage,weight: .bold)
            case .h5:
                return .systemFont(ofSize: 18*devicePercentage,weight: .regular)
            case .h6:
                return .systemFont(ofSize: 16*devicePercentage,weight: .regular)
            case .h7:
                return .systemFont(ofSize: 14*devicePercentage,weight: .regular)
            case .h8:
                return .systemFont(ofSize: 12*devicePercentage,weight: .regular)

            }
        }
    }

    static func appFont(_ font:sysFont)->UIFont{
        return font.value
    }
}
