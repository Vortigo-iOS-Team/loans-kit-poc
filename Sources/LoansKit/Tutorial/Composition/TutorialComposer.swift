import UIKit

public final class TutorialComposer {
    public static func startScene(at navigation: UINavigationController) {
        let coordinator = TutorialCoordinator(from: navigation)
        let service = TutorialService(networkManager: <#T##<<error type>>#>)
        let viewModel = TutorialViewModel(coordinator: coordinator,
                                          service: service,
                                          analytics: <#T##<<error type>>#>,
                                          store: <#T##<<error type>>#>)
        let viewController = TutorialViewController(with: viewModel)

        coordinator.start(viewController)
    }
}
