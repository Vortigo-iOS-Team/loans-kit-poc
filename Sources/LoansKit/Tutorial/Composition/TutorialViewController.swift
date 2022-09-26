import UIKit

final class TutorialViewController: UIViewController {
    
    private let acitivityIndicator: UIActivityIndicatorView = {
        let loadingIndicator = UIActivityIndicatorView(style: .whiteLarge)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.isHidden = true
        loadingIndicator.layer.zPosition = 1
        return loadingIndicator
    }()
    
    private let viewModel: TutorialViewModelProtocol
    internal let coordinator: TutorialCoordinatorProtocol
    
    init(with viewModel: TutorialViewModelProtocol, _ coordinator: TutorialCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        
        super.init(nibName: nil, bundle: nil)
        
        setupView()
        loadTutorial()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setupViewHierarchy()
        setupViewConstraints()
        setupViewStyle()
        setupBindings()
    }
    
    private func loadTutorial() {
        viewModel.fetchTutorial()
    }
    
    private func setupViewHierarchy() {
        view.addSubview(acitivityIndicator)
    }

    private func setupViewConstraints() {
        view.addConstraints([
            acitivityIndicator.heightAnchor.constraint(equalToConstant: 100),
            acitivityIndicator.widthAnchor.constraint(equalToConstant: 100),
            acitivityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            acitivityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setupViewStyle() {
        view.backgroundColor = .gray
    }

    private func setupBindings() {
        viewModel.loading.bind { [weak self] startLoading in
            startLoading ? self?.acitivityIndicator.startAnimating() : self?.acitivityIndicator.stopAnimating()
        }
        
        viewModel.viewObject.bind { tutorial in
            print("asd tutorial: ", tutorial)
        }
        
        viewModel.error.bind { error in
            print("asd error: ", error)
        }
        
        viewModel.endTutorial.bind { [weak self] shouldEnd in
            guard let self = self else { return }
            if shouldEnd {
                self.coordinator.endCoordinator()
            }
        }
    }
}
