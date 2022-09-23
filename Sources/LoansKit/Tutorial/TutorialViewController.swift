import UIKit

final class TutorialViewController: UIViewController {
    private let viewModel: TutorialViewModelProtocol

    init(with viewModel: TutorialViewModelProtocol) {
        self.viewModel = viewModel

        super.init(frame: .zero)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        setupViewHierarchy()
        setupViewConstraints()
        setupBindings()
    }

    private func setupViewHierarchy() {
        // add views to superview
    }

    private func setupViewConstraints() {
        // setup constraints
    }

    private func setupViewStyle() {
        // other UI configs
    }

    private func setupBindings() {
        // set view models value to fields
        viewModel.viewObject.bind { [weak self] viewObject in
            guard let self = self, let viewObject = viewObject else {
                // show default error
            }
            print(viewObject)
        }
    }
}
