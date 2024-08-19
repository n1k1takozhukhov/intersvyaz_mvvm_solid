import UIKit
import SnapKit

final class ImageDetailViewController: UIViewController {
    
    //MARK: Variables
    private let viewModel: CollectionImageCellViewModel
     
    
    //MARK: UI Components
    private let imageView = makeImageView()
    private let titleLabel = makeLabel()
    private let activityIndicator = makeActivityIndicator()
    
    
    //MARK: LifeCycle
    init(imageViewModel: CollectionImageCellViewModel) {
        self.viewModel = imageViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstrain()
        updateUI()
        setImageView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "square.and.arrow.up"),
            style: .plain,
            target: self,
            action: #selector(sharedImage)
        )
    }
    
    
    //MARK: Selectors
    private func updateUI() {
        title = "ImageDetailViewController"
        view.backgroundColor = .systemBackground
        
        titleLabel.text = viewModel.title
    }
    
    private func setImageView() {
        activityIndicator.startAnimating()
        if let url = viewModel.fullImageUrl {
            imageView.sd_setImage(with: url) { [weak self] _, _, _, _ in
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
    @objc private func sharedImage() {
        guard let image = imageView.image else { return }
        let shareController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(shareController, animated: true)
    }
}


//MARK: - Setup Constrain
private extension ImageDetailViewController {
    func setupConstrain() {
        setupImageView()
        setupTitleLabel()
        setupActivityIndicator()
    }
    
    func setupImageView() {
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(25)
            make.width.height.equalTo(300)
        }
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(50)
        }
    }
    
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(imageView)
        }
    }
}


//MARK: - Make UI
private extension ImageDetailViewController {
    static func makeImageView() -> UIImageView {
        let view = UIImageView()
        return view
    }
    
    static func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 16)
        view.numberOfLines = 0
        return view
    }
    
    static func makeActivityIndicator() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }
}
