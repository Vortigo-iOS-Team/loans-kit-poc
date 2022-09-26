//
//  LoansComposer.swift
//  LoansKit
//
//  Created by Douglas Pfeifer on 24/09/22.
//

import Foundation
import UIKit

public final class LoansComposer {
    public static func startLoans(at navigation: UINavigationController) -> ParentCoordinator {
        let coordinator = LoansCoordinator(from: navigation)
        coordinator.start()
        return coordinator
    }
}
