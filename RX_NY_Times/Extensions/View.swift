//
//  View.swift
//  RX_NY_Times
//
//  Created by Mohammed Essam on 03/08/2022.
//

import Foundation
import UIKit

extension UIView{
    //MARK: - Constraints
    func fillParentConstraints(widthPercentage:CGFloat = 1,heightPercentage:CGFloat = 1){
        guard let superview = self.superview else{return}
        self.centerXAnchor.constraint(equalTo:  superview.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo:  superview.centerYAnchor).isActive = true

        self.widthAnchor.constraint(equalTo:  superview.widthAnchor, multiplier: widthPercentage).isActive = true
        self.heightAnchor.constraint(equalTo:  superview.heightAnchor, multiplier: heightPercentage).isActive = true

        self.translatesAutoresizingMaskIntoConstraints = false
    }
    //My MOnster Constraints Function
    func withConstraints(toView:UIView? = nil,
                        leading:CGFloat? = nil, trailing:CGFloat? = nil,
                        top:CGFloat? = nil, bottom:CGFloat? = nil,
                                                
                        withWidth:CGFloat? = nil, withHeight:CGFloat? = nil,
                        
                        centerVertical:Bool = false,centerHorizontal:Bool = false,
                        
                        leadingToViewTrailing:CGFloat? = nil, trailingToViewLeading:CGFloat? = nil,
                        topToViewBottom:CGFloat? = nil, bottomToViewTop:CGFloat? = nil,
                        toSafeArea:Bool = true){
        
        guard let superview = toView ?? self.superview else{return}

        //Normal
        if let leading = leading{
            self.leadingAnchor.constraint(equalTo:  !toSafeArea ? superview.leadingAnchor:superview.safeAreaLayoutGuide.leadingAnchor,constant: leading).isActive = true
        }
        if let trailing = trailing{
            self.trailingAnchor.constraint(equalTo:  !toSafeArea  ? superview.trailingAnchor:superview.safeAreaLayoutGuide.trailingAnchor,constant: trailing).isActive = true
        }
        if let top = top{
            self.topAnchor.constraint(equalTo:  !toSafeArea  ? superview.topAnchor:superview.safeAreaLayoutGuide.topAnchor,constant: top).isActive = true
        }
        if let bottom = bottom{
            self.bottomAnchor.constraint(equalTo:  !toSafeArea  ? superview.bottomAnchor:superview.safeAreaLayoutGuide.bottomAnchor,constant: bottom).isActive = true
        }

        //Upnormal
        if let leadingToViewTrailing = leadingToViewTrailing{
            self.leadingAnchor.constraint(equalTo:  !toSafeArea  ? superview.trailingAnchor:superview.safeAreaLayoutGuide.trailingAnchor,constant: leadingToViewTrailing).isActive = true
        }
        if let trailingToViewLeading = trailingToViewLeading{
            self.trailingAnchor.constraint(equalTo:  !toSafeArea  ? superview.leadingAnchor:superview.safeAreaLayoutGuide.leadingAnchor,constant: trailingToViewLeading).isActive = true
        }
        if let topToViewBottom = topToViewBottom{
            self.topAnchor.constraint(equalTo:  !toSafeArea  ? superview.bottomAnchor:superview.safeAreaLayoutGuide.bottomAnchor,constant: topToViewBottom).isActive = true
        }
        if let bottomToViewTop = bottomToViewTop{
            self.bottomAnchor.constraint(equalTo:  !toSafeArea  ? superview.topAnchor:superview.safeAreaLayoutGuide.topAnchor,constant: bottomToViewTop).isActive = true
        }
        
        //Centering
        if centerVertical{
            self.centerYAnchor.constraint(equalTo:  superview.centerYAnchor).isActive = true
        }
        if centerHorizontal{
            self.centerXAnchor.constraint(equalTo:  superview.centerXAnchor).isActive = true
        }
        
        //withExactSizeConstraints
        if let withWidth = withWidth{
            self.widthAnchor.constraint(equalToConstant: withWidth).isActive = true
        }
        if let withHeight = withHeight{
            self.heightAnchor.constraint(equalToConstant: withHeight).isActive = true
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
    
    //MARK: - Design
    func withRoundedCorner(_ radius: CGFloat = DesignSystem.buttonHeight*0.25,topEdgesOnly:Bool = false,bottomEdgesOnly:Bool = false){
        if topEdgesOnly{
            self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        }
        if bottomEdgesOnly{
            self.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        }
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func withBorder(lineWidth: CGFloat = 1, lineColor: DesignSystem.sysColor = .secondry ) {
        self.layer.borderWidth = lineWidth
        self.layer.borderColor = lineColor.value.cgColor
    }
    
    func withShadow(color: DesignSystem.sysColor = .primary,opacity: Float = 0.2, offset: CGSize = CGSize(width: 0.5, height: 2.0)){
        self.layer.shadowColor = DesignSystem.appColor(color).cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = self.layer.cornerRadius
        self.layer.shadowOpacity = opacity
        self.layer.masksToBounds = true
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.layer.cornerRadius).cgPath
    }
    //MARK: - variables
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
}
