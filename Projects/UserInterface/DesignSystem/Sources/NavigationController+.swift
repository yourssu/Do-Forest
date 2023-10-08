//
//  NavigationController+.swift
//  DesignSystem
//
//  Created by 정종인 on 10/9/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import UIKit

extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self // swipe로 뒤로 가기 활성화
    }

    open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
