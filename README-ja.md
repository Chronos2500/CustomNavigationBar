# CustomNavigationBar

[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

[English is here.](README.md)

CustomNavigationBar は、スクロールに応じてナビゲーションバーの背景透明度やカスタムバックボタンの表示をアニメーションで制御するSwiftUI用のシンプルなパッケージです。  
（この効果は、AppStoreアプリやApple純正のMusicアプリなどで見られるUIを再現しています。）

![Demo](Assets/demo.gif)
## 特徴
- スクロールに合わせた任意の位置でのナビゲーションバー背景のフェードイン・アウトエフェクト
- カスタムデザインのバックボタンを実装可能
- シンプルな API で既存のコードに容易に導入できる
- 既存のスワイプバックジェスチャーの維持
- SwiftUI の `ScrollView`、(`List`、`Form`) に対応

## 動作環境
- iOS 15.0+

## インストール
Swift Package Manager (SPM) を使用してインストールできます。

1. Xcode でプロジェクトを開きます。
1. **File > Add Package Dependency...** を選択します。
1. `https://github.com/Chronos2500/CustomNavigationBar.git` を入力します。
1. バージョン指定ルール等を設定し、**Add Package** をクリックします。

## 使い方

### 基本的な使い方
1. NavigationStack等でラップされたスクロールコンテナ（`ScrollView` など）に `.scrollAwareNavBar()` 修飾子を追加します。  
2. ヘッダー部分の View には `.headerViewAnchor()` 修飾子を追加します。  
3. 必要に応じてカスタムバックボタンの挙動やデザインをパラメータで設定します。

*  `.scrollAwareNavBar()` 修飾子は、対象のスクロールコンテナのtopのsafeAreaを無視します。
*  伸縮可能なヘッダーとして [StretchHeaderImage](Sources/CustomNavigationBar/Components/StretchHeaderImage.swift) (iOS17+) を使用することをお勧めします。


```swift
import SwiftUI
import CustomNavigationBar

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                StretchHeaderImage(imageName: "header_image")
                    .headerViewAnchor()
                Text("スクロールしてナビゲーションバーが変化します")
                    .font(.title)
                    .padding()
                }
            }
            .scrollAwareNavBar(
                navBarFadeMode: .progressive,
                backButtonDesign: .dark
            )
        }
    }
}
```


### 各種カスタマイズ
```
func scrollAwareNavBar(
    isCustomNavBarFading: Bool = true,
    navBarFadeMode: NavBarFadeMode = .progressive,
    navBarFadeThresh: CGFloat = 0.8,
    isCustomBackButtonEnabled: Bool = true,
    backButtonDesign: BackButtonDesign = .dark,
    showCustomBackButtonThresh: CGFloat = 0.9
) -> some View
```
* [NavBarFadeMode](Sources/CustomNavigationBar/NavBarFadeMode.swift) : ナビゲーションバーの背景のフェードイン・アウトのモード
* [BackButtonDesign](Sources/CustomNavigationBar/BackButtonDesign.swift) : カスタムバックボタンの見た目やアニメーションの挙動


### サンプル実装
[Examplesフォルダのプロジェクト](Examples/CustomNavigationBarExample/CustomNavigationBar/ContentView.swift) のアプリにいくつかのサンプルがありますので、ご参照ください。サンプルでは[CustomNavigationTitle](https://github.com/Chronos2500/CustomNavigationTitle) パッケージも使用されています。

<table>
  <tr>
    <td align="center"><img src="Assets/appstore_demo.gif" width="150"></td>
    <td align="center"><img src="Assets/musicapp1_demo.gif" width="150"></td>
    <td align="center"><img src="Assets/musicapp2_demo.gif" width="150"></td>
  </tr>
</table>

## 貢献
イシューやバグの報告、機能の提案、プルリクエストは大歓迎です。

## 謝辞
* [Mehdi Kharraz](https://x.com/imkh0) の既存アプリの解析を参考にしました。
* [codelaby](https://x.com/codelaby/status/1891776284553793566) の共有してくださったコードを[StretchHeaderImage](Sources/CustomNavigationBar/Components/StretchHeaderImage.swift) で使用しています。
## ライセンス
MIT ライセンスのもとで提供されます。

Chronos2500 © 2025
