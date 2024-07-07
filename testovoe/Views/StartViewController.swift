import UIKit
import SnapKit

final class StartViewController: UIViewController {
    
    //MARK: Variables
    
    
    //MARK: UI Components
    private lazy var pushButton = makeButton()
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstrain()
        updateUI()
    }
    
    //MARK: Selectors
    private func updateUI() {
        pushButton.setTitle("view".uppercased(), for: .normal)
        pushButton.tintColor = .systemBlue
    }
    
    @objc func didTapButton() {
        let galleryController = GalleryViewController()
        self.navigationController?.pushViewController(galleryController, animated: true)
    }
}


//MARK: - Setup Constrain
private extension StartViewController {
    func setupConstrain() {
        setupButton()
    }
    
    func setupButton() {
        view.addSubview(pushButton)
        
        pushButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().inset(40)
        }
    }
}


//MARK: - Make UI
private extension StartViewController {
    func makeButton() -> UIButton {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 84/255, green: 118/255, blue: 171/255, alpha: 1)
        view.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.layer.cornerRadius = 15
        return view
    }
}

