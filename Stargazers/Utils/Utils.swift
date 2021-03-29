//
//  File.swift
//  Stargazers
//
//  Created by zsolt on 29/03/2021.
//

import UIKit

extension UIView {
    
    @IBInspectable
        var cornerRadius: CGFloat {
            get { return layer.cornerRadius }
            set {
                layer.cornerRadius = newValue
                layer.masksToBounds = newValue > 0
            }
        }
        
        @IBInspectable
        var borderWidth: CGFloat {
            get { return layer.borderWidth }
            set { layer.borderWidth = newValue }
        }
        
        @IBInspectable
        var borderColor: UIColor? {
            get {
                guard let color = layer.borderColor else {
                    return nil
                }
                return UIColor(cgColor: color)
            }
            set { layer.borderColor = newValue?.cgColor }
        }
}
