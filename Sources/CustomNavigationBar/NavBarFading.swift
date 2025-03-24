import SwiftUI
import UIKit

struct NavBarFading: UIViewControllerRepresentable {
    var alpha: CGFloat

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        guard let navigationController = uiViewController.navigationController else { return }
        // navbar background alpha layer
        navigationController.navigationBar.subviews.first?.alpha = alpha
    }
}
