import SwiftUI
import UIKit

public struct CustomBackButtonView: UIViewControllerRepresentable {
    @Binding public var isShowCustomBackButton: Bool
    private let design: BackButtonDesign

    public init(isShowCustomBackButton: Binding<Bool>, design: BackButtonDesign = .dark) {
        self._isShowCustomBackButton = isShowCustomBackButton
        self.design = design
    }

    public func makeUIViewController(context: Context) -> UIViewController {
        return BackButtonViewControllerWrapper(
            isShowCustomBackButton: $isShowCustomBackButton,
            design: design
        )
    }

    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if let wrapper = uiViewController as? BackButtonViewControllerWrapper {
            wrapper.updateBackButton(isShowCustomBackButton: isShowCustomBackButton)
        }
    }

    class BackButtonViewControllerWrapper: UIViewController, UIGestureRecognizerDelegate {
        @Binding var isShowCustomBackButton: Bool
        private let design: BackButtonDesign

        init(
            isShowCustomBackButton: Binding<Bool>,
            design: BackButtonDesign
        ) {
            self._isShowCustomBackButton = isShowCustomBackButton
            self.design = design
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            updateBackButton(isShowCustomBackButton: isShowCustomBackButton)

        }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            setupInteractivePopGesture()
            checkAndUpdateBackButtonVisibility()
        }

        // インタラクティブなポップジェスチャーの設定
        private func setupInteractivePopGesture() {
            if let navigationController = self.navigationController {
                navigationController.interactivePopGestureRecognizer?.delegate = self
                navigationController.interactivePopGestureRecognizer?.isEnabled = true
            }
        }

        // 最初の画面の場合はカスタムバックボタンを非表示にする
        private func checkAndUpdateBackButtonVisibility() {
            if let navigationController = self.navigationController,
               navigationController.viewControllers.count <= 1 && isShowCustomBackButton {
                DispatchQueue.main.async {
                    self.isShowCustomBackButton = false
                }
            }
        }

        func updateBackButton(isShowCustomBackButton: Bool) {
            guard let navigationController = self.navigationController,
                  let navigationItem = navigationController.visibleViewController?.navigationItem else { return }

            // navigationStackが存在しない場合はカスタムボタンを表示しない
            if navigationController.viewControllers.count <= 1 {
                navigationItem.setLeftBarButton(nil, animated: false)
                navigationItem.setHidesBackButton(false, animated: false)
                return
            }

            // ボタンの表示状態を更新
            if isShowCustomBackButton {
                navigationItem.setHidesBackButton(true, animated: false)

                // 既存のボタンがある場合はそのまま表示
                if navigationItem.leftBarButtonItem?.customView != nil {
                    return
                }

                // 新しいボタンを作成して表示
                let backButton = createBackButton()
                let barButtonItem = UIBarButtonItem(customView: backButton)

                navigationItem.setLeftBarButton(barButtonItem, animated: false)
                animateButtonAppearance(button: backButton)
            } else {
                hideBackButton(navigationItem: navigationItem)
            }
        }
        // カスタムバックボタンを作成する
        private func createBackButton() -> UIButton {
            var config = UIButton.Configuration.plain()

            // ボタンのアイコン設定
            let imageConfig = UIImage.SymbolConfiguration(pointSize: design.iconSize, weight: design.iconWeight)
            let backImage = UIImage(systemName: design.iconName, withConfiguration: imageConfig)
            config.image = backImage

            // ボタンの背景をぼかし付きにする
            config.background.visualEffect = UIBlurEffect(style: design.blurStyle)
            config.background.cornerRadius = design.cornerRadius

            // 背景の余白を設定（背景サイズの調整）
            config.background.backgroundInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

            // アイコンの位置を微調整
            config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

            // ボタンを作成
            let button = UIButton(configuration: config)
            button.tintColor = design.tintColor
            button.addTarget(self, action: #selector(self.backButtonTapped), for: .touchUpInside)
            button.frame = CGRect(x: 0, y: 0, width: design.buttonSize.width, height: design.buttonSize.height)
            button.alpha = 0.0
            button.center.x -= design.animationOffset
            return button
        }

        // ボタン表示アニメーション
        private func animateButtonAppearance(button: UIButton) {
            UIView.animate(withDuration: design.animationDuration, delay: 0, options: [.beginFromCurrentState], animations: {
                button.alpha = 1.0
                button.center.x += self.design.animationOffset
                button.center = CGPoint(x: self.design.buttonSize.width / 2, y: self.design.buttonSize.height / 2)
            })
        }

        // ボタン非表示アニメーション
        private func hideBackButton(navigationItem: UINavigationItem) {
            if let customView = navigationItem.leftBarButtonItem?.customView {
                customView.transform = .identity
                UIView.animate(withDuration: design.animationDuration, delay: 0, options: [.beginFromCurrentState], animations: {
                    customView.alpha = 0.0
                    customView.center.x -= self.design.animationOffset
                }, completion: { _ in
                    // アニメーション完了後に標準の戻るボタンに戻す
                    navigationItem.setLeftBarButton(nil, animated: false)
                    navigationItem.setHidesBackButton(false, animated: false)
                })
            } else {
                // customViewが存在しなければ即時に標準の戻るボタンを表示
                navigationItem.setLeftBarButton(nil, animated: false)
                navigationItem.setHidesBackButton(false, animated: false)
            }
        }

        @objc private func backButtonTapped() {
            // 前の画面にpopする
            if let navigationController = self.navigationController {
                navigationController.popViewController(animated: true)
            }
        }
    }
}
