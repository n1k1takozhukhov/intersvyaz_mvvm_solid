import UIKit
import SnapKit
import SDWebImage

final class ImageCell: UICollectionViewCell {
    
    //MARK: UI Components
    private let imageView = makeImageView()
    
    //MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstrain()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Selectors
    func configure(with image: ImageModel) {
        if let url = URL(string: image.thumbnailUrl) {
            imageView.sd_setImage(with: url, placeholderImage: nil) //cache
        }
    }
}


//MARK: - Setup Constrain
private extension ImageCell {
    func setupConstrain() {
        setupImageView()
    }
    
    func setupImageView() {
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


//MARK: - Make UI
private extension ImageCell {
    static func makeImageView() -> UIImageView {
        let view = UIImageView()
        return view
    }
}
