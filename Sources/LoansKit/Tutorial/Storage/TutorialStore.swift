protocol TutorialStoreProtocol {
    func updateStep(_ step: TutorialUserStep)
}

final class TutorialStore: TutorialStoreProtocol {
    private var userStep = TutorialUserStep.first

    func updateStep(_ step: TutorialUserStep) {
        userStep = step
    }

    func getUserCurrentStep() -> TutorialUserStep {
        return userStep
    }
}
