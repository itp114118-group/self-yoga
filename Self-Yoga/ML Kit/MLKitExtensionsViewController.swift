//import CoreGraphics
//import UIKit
//
//// MARK: - UIImage
//
//extension UIImage {
//
//  public func scaledImage(with size: CGSize) -> UIImage? {
//    UIGraphicsBeginImageContextWithOptions(size, false, scale)
//    defer { UIGraphicsEndImageContext() }
//    draw(in: CGRect(origin: .zero, size: size))
//    return UIGraphicsGetImageFromCurrentImageContext()?.data.flatMap(UIImage.init)
//  }
//
//  // MARK: - Private
//
//  /// The PNG or JPEG data representation of the image or `nil` if the conversion failed.
//  private var data: Data? {
//    #if swift(>=4.2)
//      return self.pngData() ?? self.jpegData(compressionQuality: Constant.jpegCompressionQuality)
//    #else
//      return self.pngData() ?? self.jpegData(compressionQuality: Constant.jpegCompressionQuality)
//    #endif  // swift(>=4.2)
//  }
//}
//
//// MARK: - Constants
//
//private enum Constant {
//  static let jpegCompressionQuality: CGFloat = 0.8
//}
//
