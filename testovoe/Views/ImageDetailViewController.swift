import UIKit
import SnapKit

final class ImageDetailViewController: UIViewController {
    
    //MARK: Variables
    private let imageModel: ImageModel

    
    //MARK: UI Components
    private let imageView = makeImageView()
    private let titleLabel = makeLabel()
    
    
    //MARK: LifeCycle
    init(imageModel: ImageModel) {
        self.imageModel = imageModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstrain()
        updateUI()
        setImageView(with: imageModel)
        
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
        
        titleLabel.text = imageModel.title
    }
    
    private func setImageView(with image: ImageModel) {
        if let url = URL(string: image.url) {
            imageView.sd_setImage(with: url, placeholderImage: nil)
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
        view.font = .systemFont(ofSize: 20)
        view.numberOfLines = 0
        return view
    }
}

