import UIKit

protocol TutorialCoordinatorProtocol {
    func showHelpFlow()
}

final class TutorialCoordinator {
    private let navigation: UINavigationController

    init(from navigation: UINavigationController) {
        self.navigation = navigation
    }

    func start(_ viewController: UIViewController) {
        navigation.pushViewController(viewController, animated: true)
    }
}

extension TutorialCoordinator: TutorialCoordinatorProtocol {
    func showHelpFlow() {
        // call next composer.start()
    }
}
