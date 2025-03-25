# CustomNavigationBar

[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

[日本語はこちら](README-ja.md)

CustomNavigationBar is a simple SwiftUI package that allows you to animate the transparency of the navigation bar background and the appearance of a custom back button based on scrolling.  
(This effect replicates the UI seen in Apple's App Store and Music app.)

![Demo](Assets/demo.gif)

## Features
- Fade-in and fade-out effects for the navigation bar background at customizable scroll positions
- Ability to implement a custom-designed back button
- Easy integration with existing code via a simple API
- Retains the default swipe-back gesture functionality
- Supports SwiftUI's `ScrollView` (`List` and `Form`)

## Requirements
- iOS 15.0+

## Installation
You can install this package using Swift Package Manager (SPM).

1. Open your project in Xcode.
2. Select **File > Add Package Dependency...**.
3. Enter `https://github.com/Chronos2500/CustomNavigationBar.git`.
4. Set version rules as needed and click **Add Package**.

## Usage

### Basic Usage
1. Apply the `.scrollAwareNavBar()` modifier to a scroll container (`ScrollView`, etc.) wrapped in a `NavigationStack`.
2. Add the `.headerViewAnchor()` modifier to the header view.
3. Customize the behavior and design of the back button using parameters if necessary.

* The `.scrollAwareNavBar()` modifier ignores the top safe area of the scroll container.
* For a stretchable header, it is recommended to use [StretchHeaderImage](Sources/CustomNavigationBar/Components/StretchHeaderImage.swift) (iOS 17+).

```swift
import SwiftUI
import CustomNavigationBar

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                StretchHeaderImage(imageName: "header_image")
                    .headerViewAnchor()
                Text("Scroll to see the navigation bar change")
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
```


### Customization Options
``` swift
func scrollAwareNavBar(
    isCustomNavBarFading: Bool = true,
    navBarFadeMode: NavBarFadeMode = .progressive,
    navBarFadeThresh: CGFloat = 0.8,
    isCustomBackButtonEnabled: Bool = true,
    backButtonDesign: BackButtonDesign = .dark,
    showCustomBackButtonThresh: CGFloat = 0.9
) -> some View
```
* [NavBarFadeMode](Sources/CustomNavigationBar/NavBarFadeMode.swift): Controls the fade-in and fade-out behavior of the navigation bar background.  
* [BackButtonDesign](Sources/CustomNavigationBar/BackButtonDesign.swift): Defines the appearance and animation behavior of the custom back button.


### Sample Implementations
Several examples can be found in the [Examples](Examples/CustomNavigationBarExample/CustomNavigationBarExample/ContentView.swift) folder. These examples also utilize the [CustomNavigationTitle](https://github.com/Chronos2500/CustomNavigationTitle) package.

<table>
  <tr>
    <td align="center"><img src="Assets/appstore_demo.gif" width="150"></td>
    <td align="center"><img src="Assets/musicapp1_demo.gif" width="150"></td>
    <td align="center"><img src="Assets/musicapp2_demo.gif" width="150"></td>
  </tr>
</table>

## Contribution
Bug reports, feature requests, and pull requests are always welcome!

## Acknowledgments
* Based on analysis of existing apps by [Mehdi Kharraz](https://x.com/imkh0).
* Uses code shared by [codelaby](https://x.com/codelaby/status/1891776284553793566) in [StretchHeaderImage](Sources/CustomNavigationBar/Components/StretchHeaderImage.swift).

## License
This project is available under the MIT License.

Chronos2500 © 2025


