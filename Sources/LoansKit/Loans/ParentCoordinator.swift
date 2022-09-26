//
//  ParentCoordinator.swift
//  LoansKit
//
//  Created by Douglas Pfeifer on 24/09/22.
//

import Foundation
import UIKit

public protocol ParentCoordinator: AnyObject {
    var navigation: UINavigationController { get }
    
    func end(_ coordinator: ParentCoordinator)
}

extension ParentCoordinator {
    internal func start(_ viewController: UIViewController) {
        navigation.pushViewController(viewController, animated: true)
    }
}
