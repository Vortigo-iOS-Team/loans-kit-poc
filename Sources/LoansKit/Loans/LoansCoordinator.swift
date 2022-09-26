//
//  LoansCoordinator.swift
//  LoansKit
//
//  Created by Douglas Pfeifer on 24/09/22.
//

import Foundation
import UIKit

internal final class LoansCoordinator: NSObject, ParentCoordinator {
    internal var childCoordinators = [ChildCoordinator]()
    internal let navigation: UINavigationController
    
    internal init(from navigationController: UINavigationController) {
        self.navigation = navigationController
    }
    
    internal func start() {
        navigation.delegate = self
        
        startTutorial()
    }
    
    func end(_ coordinator: ParentCoordinator) {
        
    }
    
    private func startTutorial() {
        let child = TutorialComposer.startScene(at: navigation)
        child.parentCoordinator = self
        childCoordinators.append(child)
    }
    
    internal func childDidEnd(_ child: ChildCoordinator) {
        print("asd childDidEnd: ", child)
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

// MARK: - Return button handling
extension LoansCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // First get the view controller we are moving from
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        // Second check if our view controller array already contains that view controller
        // If true we are pushing a view controller on top
        if navigationController.viewControllers.contains(fromViewController) { return }
        // If we are here the coordinator endded
        if let tutorialViewController = fromViewController as? TutorialViewController,
           let child = tutorialViewController.coordinator as? ChildCoordinator {
            childDidEnd(child)
        }
    }
}
