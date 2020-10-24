import UIKit

public class FontsConfigurator {
    public init() {}

    fileprivate let fonts = [
        R.file.cairoBlackTtf.path(),
        R.file.cairoBoldTtf.path(),
        R.file.cairoExtraLightTtf.path(),
        R.file.cairoLightTtf.path(),
        R.file.cairoRegularTtf.path(),
        R.file.cairoSemiBoldTtf.path(),
    ]

    public func initialize() {
        fonts.forEach { UIFont.loadFontWith(path: $0) }
    }
}

extension UIFont {
    private class FontConfiguratorClass {}

    static func loadFontWith(path: String?) {
        guard let path = path,
            let fontData = NSData(contentsOfFile: path),
            let dataProvider = CGDataProvider(data: fontData),
            let fontRef = CGFont(dataProvider) else {
                return
        }

        var errorRef: Unmanaged<CFError>?

        if CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) == false {
            assertionFailure("Failed to register font may have already been registered in the main bundle.")
        }
    }
}
