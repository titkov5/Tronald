import Foundation
import UIKit

class BindableImageViewModel: CommonViewModel {

    // MARK: - Public Properties

    let image = Observable<UIImage?>(nil, equality: nil)
    let contentMode: UIViewContentMode

    // MARK: - Constructors

    init(image: UIImage? = nil, contentMode: UIViewContentMode) {
        self.image.value = image
        self.contentMode = contentMode
    }

    // MARK: - Public Methods

    override class func viewClass() -> CommonView.Type {
        return BindableImage.self
    }

}

class BindableImage: CommonView {
    
    // MARK: - Public Properties

    override var intrinsicContentSize: CGSize {
        return imageView.intrinsicContentSize
    }

    // MARK: - Public
    
    override func model() -> BindableImageViewModel? {
        return super.model() as? BindableImageViewModel
    }

    // MARK: -

    override func setupViews() {
        super.setupViews()

        addSubview(imageView)
    }

    override func setupConstraints() {
        super.setupConstraints()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.fillContainer()
    }

    // MARK: -

    override func bind(to model: CommonViewModel?) {
        super.bind(to: model)
        guard let model = self.model() else {
            imageObserver = nil
            return
        }

        imageView.contentMode = model.contentMode
        imageObserver = model.image.addObserver(callImmediately: true) { [weak self] image in
            self?.imageView.image = image
        }
    }

    // MARK: - Private Properties

    fileprivate let imageView = UIImageView()

    fileprivate var imageObserver: Observer<UIImage?>?

}
