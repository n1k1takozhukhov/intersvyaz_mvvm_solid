import UIKit
import SnapKit

final class GalleryViewController: UIViewController {
   
    //MARK: Variables
    private let viewModel = GalleryViewModel()
    
    
    //MARK: UI Components
    private lazy var collectionView = makeCollectionView()
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstrain()
        updateUI()
        setupHook()
        viewModel.fetchImage()
    }
    
    
    //MARK: Selectors
    private func updateUI() {
        title = "GalleryViewController"
        view.backgroundColor = .systemBackground
        
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupHook() {
        viewModel.reloadCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}


//MARK: - Setup Constrain
private extension GalleryViewController {
    func setupConstrain() {
        setupImageView()
    }
    
    func setupImageView() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview()
        }
    }
}


//MARK: - UICollectionViewDataSource
extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfImage()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCell
        let image = viewModel.image(at: indexPath.row)
        cell.configure(with: image)
        return cell
    }
}


//MARK: - UICollectionViewDelegate
extension GalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectImage = viewModel.image(at: indexPath.row)
        let viewDetail = ImageDetailViewController(imageModel: selectImage)
        self.navigationController?.pushViewController(viewDetail, animated: true)
    }
}


//MARK: - Make UI
private extension GalleryViewController {
    func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 80, height: 80)
        return UICollectionView(
            frame: .zero, collectionViewLayout: layout)
    }
}
