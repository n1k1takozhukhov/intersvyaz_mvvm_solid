import Foundation

final class ImageCellViewModel {
    
    //MARK: Variables
    private let imageModel: ImageModel
     
    var title: String {
        return imageModel.title
    }
    
    var thumbnailUrl: URL? {
        return URL(string: imageModel.thumbnailUrl)
    }
    
    var fullImageUrl: URL? {
        return URL(string: imageModel.url)
    }
    
    //MARK: LifeCycle
    init(imageModel: ImageModel) {
        self.imageModel = imageModel
    }
}
