//
//  UINavigationController.swift
//  swiftui-social
//
//  Created by song dong hyeok on 11/30/24.
//

import UIKit

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
