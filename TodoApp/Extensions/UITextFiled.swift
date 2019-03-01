//
//  UITextFiled.swift
//  TodoApp
//
//  Created by Akash Srivastava on 01/03/19.
//  Copyright © 2019 Akash Srivastava. All rights reserved.
//

import Foundation
import UIKit


extension UITextField {
    @IBInspectable var textInsets: CGPoint {
        get {
            return CGPoint.zero
        }
        set {
            layer.sublayerTransform = CATransform3DMakeTranslation(newValue.x, newValue.y, 0);
        }
    }
}
