struct TutorialModel: Decodable, Equatable {
    let title: String
}

extension TutorialModel {
    func toViewObject() -> TutorialViewObject {
        return TutorialViewObject(title: title)
    }
}
