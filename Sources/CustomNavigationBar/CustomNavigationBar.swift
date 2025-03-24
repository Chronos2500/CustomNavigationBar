#if os(iOS)

import SwiftUI

struct CNBPreferenceKey: PreferenceKey {
    typealias Value = Anchor<CGRect>?
    static let defaultValue: Value = nil
    static func reduce(value: inout Value, nextValue: () -> Value) {
        guard let newValue = nextValue() else { return }
        value = newValue
    }
}

extension View {
    public func headerViewAnchor() -> some View {
        self.anchorPreference(
            key: CNBPreferenceKey.self,
            value: .bounds
        ) { anchor in
            anchor
        }
    }
}

private struct ScrollAwareNavBarModifier: ViewModifier {
    //When setting it to 0.0, the opacity reverts to the default on the first scroll after the transition.
    @State private var navBarAlpha: CGFloat = 1e-10
    @State private var isShowCustomBackButton: Bool = true

    let isCustomNavBarFading: Bool
    let navBarFadeMode: NavBarFadeMode
    let navBarFadeThresh: CGFloat

    let isCustomBackButtonEnabled: Bool
    let backButtonDesign: BackButtonDesign
    let showCustomBackButtonThresh: CGFloat

    init(isCustomNavBarFading: Bool, navBarFadeMode: NavBarFadeMode, navBarFadeThresh: CGFloat, isCustomBackButtonEnabled: Bool, backButtonDesign: BackButtonDesign, showCustomBackButtonThresh: CGFloat) {
        self.isCustomNavBarFading = isCustomNavBarFading
        self.navBarFadeMode = navBarFadeMode
        self.navBarFadeThresh = max(0, min(navBarFadeThresh, 1))
        self.isCustomBackButtonEnabled = isCustomBackButtonEnabled
        self.backButtonDesign = backButtonDesign
        self.showCustomBackButtonThresh = max(0, min(showCustomBackButtonThresh, 1))
    }

    func body(content: Content) -> some View {
        content
            .modifier(ContentMarginsModifier())
            .ignoresSafeArea(edges: .top)
            .modifier(NavBarFadingModifier(isCustomNavBarFading: isCustomNavBarFading, navBarAlpha: navBarAlpha))
            .modifier(CustomBackButtonModifier(isShowCustomBackButton: $isShowCustomBackButton, isCustomBackButtonEnabled: isCustomBackButtonEnabled, backButtonDesign: backButtonDesign))
            .backgroundPreferenceValue(CNBPreferenceKey.self) { anchor in
                GeometryReader { proxy in
                    if let anchor = anchor {
                        let scrollFrame = proxy.frame(in: .local)
                        let itemFrame = proxy[anchor]
                        var progress = (scrollFrame.minY - itemFrame.minY - proxy.safeAreaInsets.top) / (itemFrame.height - proxy.safeAreaInsets.top)
                        progress = restrictValue(progress)
                        DispatchQueue.main.async{
                            if navBarFadeMode == .progressive {
                                navBarAlpha = progress
                            } else if navBarFadeMode == .threshold {
                                if progress <= navBarFadeThresh {
                                    navBarAlpha = 0.0
                                } else {
                                    navBarAlpha = (progress - navBarFadeThresh) / (1 - navBarFadeThresh)
                                }
                            }
                        }
                        
                        DispatchQueue.main.async{
                            if progress > showCustomBackButtonThresh {
                                isShowCustomBackButton = false
                            } else {
                                isShowCustomBackButton = true
                            }
                        }
                    }
                    return Color.clear
                }
            }
    }
    func restrictValue(_ value: CGFloat) -> CGFloat {
        return max(0, min(value, 1))
    }
}

extension View {
    public func scrollAwareNavBar(
        isCustomNavBarFading: Bool = true,
        navBarFadeMode: NavBarFadeMode = .progressive,
        navBarFadeThresh: CGFloat = 0.8,
        isCustomBackButtonEnabled: Bool = true,
        backButtonDesign: BackButtonDesign = .dark,
        showCustomBackButtonThresh: CGFloat = 0.9
    ) -> some View {
        modifier(ScrollAwareNavBarModifier(
            isCustomNavBarFading: isCustomNavBarFading,
            navBarFadeMode: navBarFadeMode,
            navBarFadeThresh: navBarFadeThresh,
            isCustomBackButtonEnabled: isCustomBackButtonEnabled,
            backButtonDesign: backButtonDesign,
            showCustomBackButtonThresh: showCustomBackButtonThresh
        ))
    }
}

struct NavBarFadingModifier: ViewModifier {
    let isCustomNavBarFading: Bool
    let navBarAlpha: CGFloat
    func body(content: Content) -> some View {
        if isCustomNavBarFading {
            content
                .background(
                    NavBarFading(
                        alpha: navBarAlpha
                    )
                    .frame(width: 0, height: 0)
                    .compositingGroup()
                )
        } else {
            content
        }
    }
}

struct CustomBackButtonModifier: ViewModifier {
    @Binding var isShowCustomBackButton: Bool
    let isCustomBackButtonEnabled: Bool
    let backButtonDesign: BackButtonDesign
    func body(content: Content) -> some View {
        if isCustomBackButtonEnabled {
            content
                .background(
                    CustomBackButtonView(
                        isShowCustomBackButton: $isShowCustomBackButton,
                        design: backButtonDesign
                    )
                    .frame(width: 0, height: 0)
                    .compositingGroup()
                )
        } else {
            content
        }
    }
}

struct ContentMarginsModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 17.0, *) {
            content.contentMargins(.top, 100, for: .scrollIndicators)
        } else {
            content
        }
    }
}

#endif
