protocol TutorialServiceProtocol {
    func fetchTutorial(completion: @escaping (TutorialModel?, Error?) -> Void)
}

final class TutorialService {
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

extension TutorialService: ListServiceProtocol {
    func fetchTutorial(completion: @escaping (TutorialModel?, Error?) -> Void) {
        completion(nil, nil)
        // call network kit and request data
    }
}
