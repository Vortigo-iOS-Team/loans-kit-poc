//
//  ChildCoordinator.swift
//  LoansKit
//
//  Created by Douglas Pfeifer on 24/09/22.
//

import Foundation
import UIKit

/// - WARNING: !!! ALWAYS declare parentCoordinator as WEAK !!!
internal protocol ChildCoordinator: AnyObject {
    var navigation: UINavigationController { get }
    var parentCoordinator: LoansCoordinator? { get set }
}

extension ChildCoordinator {
    internal func start(_ viewController: UIViewController) {
        navigation.pushViewController(viewController, animated: true)
    }
    
    func end(_ coordinator: ChildCoordinator) {
        parentCoordinator?.childDidEnd(self)
    }
}
