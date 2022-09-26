protocol TutorialViewModelProtocol {
    var loading: Dynamic<Bool> { get }
    var error: Dynamic<APIError?> { get }
    var viewObject: Dynamic<TutorialViewObject?> { get }
    var endTutorial: Dynamic<Bool> { get }
    
    func fetchTutorial()
    func tutorialWillEnd()
}

final class TutorialViewModel {
    private var service: TutorialService!
    
    let loading: Dynamic<Bool> = Dynamic(false)
    let error: Dynamic<APIError?> = Dynamic(nil)
    var viewObject: Dynamic<TutorialViewObject?> = Dynamic(nil)
    var endTutorial: Dynamic<Bool> = Dynamic(false)

    init(service: TutorialService) {
        self.service = service
    }
}

extension TutorialViewModel: TutorialViewModelProtocol {
    func fetchTutorial() {
        loading.value = true
        service.fetchTutorial { [ weak self] result in
            self?.loading.value = false
            switch result {
            case .success(let tutorial):
                guard let tutorial = tutorial as? TutorialModel else { return }
                self?.viewObject.value = tutorial.toViewObject()
            case .failure(let apiError):
                self?.error.value = apiError
            }
        }
    }
    
    internal func tutorialWillEnd() {
        endTutorial.value = true
    }
}
