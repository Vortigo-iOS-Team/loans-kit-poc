import UIKit

internal final class TutorialComposer {
    internal static func startScene(at navigation: UINavigationController) -> ChildCoordinator {
        let service = TutorialService()
        let coordinator = TutorialCoordinator(from: navigation)
        let viewModel = TutorialViewModel(service: service)
        let viewController = TutorialViewController(with: viewModel, coordinator)
        
        coordinator.start(viewController)
        return coordinator
    }
}
