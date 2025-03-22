//
//  AppStoreView.swift
//  CustomNavigationBarExample
//
//  Created by Chronos2500 on 2025/03/22.
//

import SwiftUI
import CustomNavigationTitle
import CustomNavigationBar

struct AppStoreView: View {
    var body: some View {
        ScrollView{
            VStack(spacing: 25){
                StreachHeaderImage(imageName: "starlit_sky")
                    .padding(.horizontal, -25)
                    .headerViewAnchor()
                HStack(alignment: .top, spacing: 25){
                    Image(.sampleIcon)
                        .resizable()
                        .frame(width: 120,height: 120)
                        .clipShape(.rect(cornerRadius: 30))
                        .shadow(color: .secondary,radius: 1)
                        .titleVisibilityAnchor()
                    VStack(alignment: .leading, spacing: 0){
                        Text("Custom Navigation Bar")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .lineLimit(2)
                        Text("Chronos2500")
                            .foregroundStyle(.secondary)
                            .padding(.top, 2)
                        Spacer()
                        HStack{
                            Button{} label: {
                                Text("Get")
                                    .bold()
                                    .foregroundStyle(.white)
                                    .padding(.horizontal,18)
                                    .padding(.vertical,5)
                                    .background(Color.blue, in: .capsule)
                            }
                            .buttonStyle(.plain)
                            Spacer()
                            Text(Image(systemName: "square.and.arrow.up"))
                                .fontWeight(.semibold)
                                .foregroundStyle(.tint)
                        }
                        .padding(.top,12)
                    }
                    .frame(maxWidth: .infinity,minHeight: 120, alignment: .leading)
                }
                Divider()
                ScrollView(.horizontal){
                    HStack(spacing: 15){
                        appDetailCapsuleView("1.0M RATINGS", "5.0", "★★★★★")
                        Divider().padding(.bottom,5)
                        appDetailCapsuleView("AGE", "12+", "Years Old")
                        Divider().padding(.bottom,5)
                        appDetailCapsuleView("CHART", "# 1", "Productivity")
                        Divider().padding(.bottom,5)
                        appDetailCapsuleView("DEVELOPER", "(^o^)", "Chronos2500")
                        Divider().padding(.bottom,5)
                        appDetailCapsuleView("LANGUAGE", "EN", "+ 1 More")
                        Divider().padding(.bottom,5)
                        appDetailCapsuleView("SIZE", "10.0", "MB")

                    }
                }
                .scrollClipDisabled()
                .scrollIndicators(.never)
                .scrollBounceBehavior(.basedOnSize)
                ScrollView(.horizontal){
                    HStack(spacing: 15){
                        ForEach(0..<5){_ in
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .foregroundStyle(.blue.gradient)
                                Text("This is Demo")
                                    .bold()
                                    .font(.system(size: 30))
                                    .foregroundStyle(.white)
                            }
                            .aspectRatio(0.5, contentMode: .fill)
                            .shadow(color: .secondary,radius: 1)

                        }
                    }
                    .scrollTargetLayout()
                    .frame(height: 490)
                }
                .scrollClipDisabled()
                .scrollTargetBehavior(.viewAligned)
                .scrollIndicators(.hidden)
                .scrollBounceBehavior(.basedOnSize)

                Divider()

                Text(
"""
This is a sample of a customized navigation bar. Some apps on the App Store have header images (such as TikTok and YouTube), and this is a simple recreation of that. The settings are as follows:
   • `navFadeMode = .progressive`
   • `backButtonDesign = .appStoreStyle`

I am also using my package called CustomNavigationTitle.
"""
                )
                HStack{
                    VStack(alignment: .leading){
                        Text("Chronos2500")
                            .foregroundStyle(.blue)
                        Text("Developer")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Text(Image(systemName: "chevron.forward"))
                        .foregroundStyle(.secondary)
                }
                Divider()
                Spacer().frame(height: 300)
            }
            .padding(.horizontal,25)
        }
        .scrollAwareNavBar(
            navBarFadeMode: .progressive,
            backButtonDesign: .appStoreStyle
        )
        .scrollAwareTitle{
            ZStack{
                Image(.sampleIcon)
                    .resizable()
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 8))
                    .shadow(color: .secondary,radius: 1)
                    .padding(8)
            }
            .frame(maxWidth: 50)
        }
    }
    @ViewBuilder
    func appDetailCapsuleView(_ title: String, _ detail: String, _ unit: String) -> some View {
        VStack(spacing: 5){
            Text(title)
                .font(.caption)
                .foregroundStyle(.tertiary)
                .fontWeight(.bold)
                .lineLimit(1)
            Text(detail)
                .font(.title2)
                .foregroundStyle(.secondary)
                .fontWeight(.bold)
                .fontDesign(.rounded)
                .lineLimit(1)
            Text(unit)
                .font(.callout)
                .foregroundStyle(.secondary)
                .fontWeight(.regular)
                .lineLimit(1)
        }
    }

}

#Preview {
    ContentView()
}

