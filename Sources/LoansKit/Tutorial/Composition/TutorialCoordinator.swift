import UIKit

internal protocol TutorialCoordinatorProtocol {
    func endCoordinator()
}

internal final class TutorialCoordinator: ChildCoordinator {
    internal var navigation: UINavigationController
    internal weak var parentCoordinator: LoansCoordinator?
    
    internal init(from navigation: UINavigationController) {
        self.navigation = navigation
    }
}

extension TutorialCoordinator: TutorialCoordinatorProtocol {
    func showHelpFlow() {
        // call next composer.start()
    }
    
    func endCoordinator() {
        print("asd end TutorialCoordinator")
        parentCoordinator?.childDidEnd(self)
    }
}
