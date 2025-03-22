import SwiftUI

public struct BackButtonDesign {
    // ボタンの見た目に関する設定
    let cornerRadius: CGFloat
    let blurStyle: UIBlurEffect.Style
    let iconName: String
    let iconSize: CGFloat
    let iconWeight: UIImage.SymbolWeight
    let tintColor: UIColor
    let buttonSize: CGSize

    // アニメーションに関する設定
    let animationDuration: TimeInterval
    let animationOffset: CGFloat

    // デフォルト値で初期化
    public init(
        cornerRadius: CGFloat = 15,
        blurStyle: UIBlurEffect.Style = .systemThinMaterialDark,
        iconName: String = "chevron.backward",
        iconSize: CGFloat = 14,
        iconWeight: UIImage.SymbolWeight = .semibold,
        tintColor: UIColor = .white,
        buttonSize: CGSize = CGSize(width: 30, height: 30),
        animationDuration: TimeInterval = 0.15,
        animationOffset: CGFloat = 10
    ) {
        self.cornerRadius = cornerRadius
        self.blurStyle = blurStyle
        self.iconName = iconName
        self.iconSize = iconSize
        self.iconWeight = iconWeight
        self.tintColor = tintColor
        self.buttonSize = buttonSize
        self.animationDuration = animationDuration
        self.animationOffset = animationOffset
    }

    // 既定のスタイル
    public static var dark: BackButtonDesign {
        BackButtonDesign(
            blurStyle: .systemThinMaterialDark,
            tintColor: .white
        )
    }

    public static var light: BackButtonDesign {
        BackButtonDesign(
            blurStyle: .systemThinMaterialLight,
            tintColor: .black
        )
    }

    public static var adaptive: BackButtonDesign {
        BackButtonDesign(
            blurStyle: .systemChromeMaterial,
            tintColor: .label
        )
    }

    public static var appStoreStyle: BackButtonDesign {
        BackButtonDesign(
            blurStyle: .systemThickMaterialLight,
            tintColor: .black.withAlphaComponent(0.5)
        )
    }

    public static var musicStyle: BackButtonDesign {
        BackButtonDesign(
            blurStyle: .systemThinMaterialDark,
            tintColor: .white.withAlphaComponent(0.9),
            animationDuration: 0.2,
            animationOffset: 0.0
        )
    }
}
