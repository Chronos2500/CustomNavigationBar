//
//  InListView.swift
//  CustomNavigationBarExample
//  
//  Created by Chronos2500 on 2025/03/22.
//

import SwiftUI
import CustomNavigationBar

struct MusicAppView2: View {
    var body: some View {
        ScrollView{
            VStack{
                StretchHeaderImage(
                    imageName: "xmas",
                    aspectRatio: 5/3
                )
                .padding(.horizontal, -16)
                .headerViewAnchor()
                Text("Holiday Music Playlist")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .titleVisibilityAnchor()
                    .padding(.bottom, 30)
                Text("A simple reproduction of the UI displayed when selecting an item in the Search tab of the Music app.\nThe holiday season is here again! Enjoy the festive spirit with playlists handpicked by a variety of artists.")
                    .padding(.bottom, 30)
                albumCardView(.red)
                    .padding(.bottom)
                albumCardView(.green)
                    .padding(.bottom)
                albumCardView(.indigo)
                    .padding(.bottom)
                Spacer().frame(height: 300)
            }
            .padding(.horizontal, 16)

        }
        .scrollAwareNavBar(
            navBarFadeMode: .threshold,
            navBarFadeThresh: 0.95,
            backButtonDesign: .musicStyle,
            showCustomBackButtonThresh: 0.97
        )

    }
    @ViewBuilder
    func albumCardView(_ color: Color) -> some View {
        VStack{
            Text("Recommended Playlists")
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            ScrollView(.horizontal){
                HStack(spacing: 15){
                    ForEach(0..<10){ index in
                        VStack(spacing: 0){
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(color.gradient)
                                Text(String(index))
                                    .bold()
                                    .font(.system(size: 30))
                                    .foregroundStyle(.white)
                            }
                            .aspectRatio(1, contentMode: .fill)
                            .frame(height: 150)
                            .padding(.bottom, 3)
                            Text("Album Name")
                                .font(.callout)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Artist Name")
                                .font(.caption)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(.secondary)

                        }

                    }
                }
                .scrollTargetLayout()

            }
            .scrollClipDisabled()
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.never)
        }
    }
}

#Preview {
    MusicAppView2()
}

