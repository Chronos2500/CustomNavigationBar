import SwiftUI
import UIKit

public enum NavBarFadeMode {
    case progressive
    case threshold

}

struct NavBarFading: UIViewControllerRepresentable {
    var alpha: CGFloat

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        guard let navigationController = uiViewController.navigationController else { return }
        // 背景の透明度のみ更新
        navigationController.navigationBar.subviews.first?.alpha = alpha
    }
}
