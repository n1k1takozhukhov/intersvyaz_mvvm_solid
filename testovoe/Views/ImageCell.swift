import UIKit
import SnapKit
import SDWebImage

final class ImageCell: UICollectionViewCell {
    
    //MARK: Variables
    private var viewModel: ImageCellViewModel?

     
    //MARK: UI Components
    private let imageView = makeImageView()
    private let activityIndicator = makeActivityIndicator()
    
    
    //MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstrain()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Selectors
    func configure(with viewModel: ImageCellViewModel) {
        self.viewModel = viewModel
        updateUI()
    }
    
    private func updateUI() {
        activityIndicator.startAnimating()
        if let url = viewModel?.thumbnailUrl {
            imageView.sd_setImage(with: url, placeholderImage: nil) { [weak self] _, _, _, _ in
                self?.activityIndicator.stopAnimating()
            }
        }
    }
}


//MARK: - Setup Constrain
private extension ImageCell {
    func setupConstrain() {
        setupImageView()
        setupActivityIndicator()
    }
    
    func setupImageView() {
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupActivityIndicator() {
        contentView.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(imageView)
        }
    }
}


//MARK: - Make UI
private extension ImageCell {
    static func makeImageView() -> UIImageView {
        let view = UIImageView()
        return view
    }
    
    static func makeActivityIndicator() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }
}
