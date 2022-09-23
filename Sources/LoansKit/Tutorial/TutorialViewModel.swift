protocol TutorialViewModelProtocol {
    var loading: Dynamic<Bool> { get }
    var error: Dynamic<String?> { get }
    var viewObject: Dynamic<TutorialViewObject?> { get }

    func fetchTutorial()
}

final class TutorialViewModel {
    let loading: Dynamic<Bool> = Dynamic(false)
    let error: Dynamic<String?> = Dynamic(nil)
    var viewObject: Dynamic<TutorialViewObject?> = Dynamic(nil)

    private let coordinator: TutorialCoordinatorProtocol
    private let service: TutorialServiceProtocol
    private let analytics: TutorialAnalyticsProvider
    private let store: TutorialStoreProtocol

    init(coordinator: TutorialCoordinatorProtocol,
         service: TutorialServiceProtocol,
         analytics: TutorialAnalyticsProvider,
         store: TutorialStoreProtocol) {
        self.coordinator = coordinator
        self.service = service
        self.analytics = analytics
        self.store = store
    }
}

extension TutorialViewModel: TutorialViewModelProtocol {
    func fetchTutorial() {
        loading.value = true

        service.fetchTutorial { [weak self] tutorial, error in
            guard let tutorial else {
                // show error
                loading.value = false
            }
            let viewObject = tutorial.toViewObject()
            self?.viewObject = viewObject
            // show infos in screen
            loading.value = false
        }
    }
}
