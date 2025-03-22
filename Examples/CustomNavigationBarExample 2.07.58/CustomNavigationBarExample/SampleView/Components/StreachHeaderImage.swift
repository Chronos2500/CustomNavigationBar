//
//  StreachHeaderImage.swift
//  CustomNavigationBarExample
//
//  Created by Chronos2500 on 2025/03/22.
//

import SwiftUI

struct StreachHeaderImage: View {
    let imageName: String
    var aspectRatio: CGFloat = 2
    let allowsOpacityChange: Bool = false

    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            // .scrollView(axis: .vertical) API is iOS 17.0+
            // Cannot use .scrollView(axis: .vertical) in List or Form
            let minY = proxy.frame(in: .scrollView(axis: .vertical)).minY
            let progress = max(min(-minY / size.height, 1), 0)
            let stretchableHeight = size.height + max(0, minY) - (proxy.safeAreaInsets.top * progress)
            Rectangle()
                .overlay {
                    // The header image that stretches when pulled down
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .clipped()
                // Fix top position
                .offset(CGSize(width: 0, height: min(0, -minY)))
                // Make the header stretchable
                .frame(width: size.width, height: stretchableHeight)
                // Apply opacity when the header collapses
                .opacity(allowsOpacityChange ? (1 - progress) : 1)
        }
        // Set the aspect ratio of the image
        .aspectRatio(aspectRatio, contentMode: .fit)
    }
}
