//
//  MusicAppView.swift
//  CustomNavigationBarExample
//  
//  Created by Chronos2500 on 2025/03/22.
//

import SwiftUI
import CustomNavigationTitle
import CustomNavigationBar

struct MusicAppView1: View {
    var body: some View {
        ScrollView{
            VStack(spacing: 0){
                StretchHeaderImage(
                    imageName: "today’s_hits",
                    aspectRatio: 4/3
                )
                ZStack{
                    Color(red: 208/255, green: 63/255, blue: 112/255)
                    VStack{
                        Spacer().frame(height: 20)
                        Text("Today's Hits")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text("Update 1h ago")
                            .font(.footnote)
                            .foregroundStyle(.thinMaterial)
                        HStack(spacing: 16){
                            Button{} label: {
                                Label("Play", systemImage: "play.fill")
                                    .bold()
                                    .font(.title3)
                                    .padding(.vertical,14)
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial, in: .rect(cornerRadius: 15))

                            }

                            Button{} label: {
                                Label("Shuffle", systemImage: "shuffle")
                                    .bold()
                                    .font(.title3)
                                    .padding(.vertical,14)
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial, in: .rect(cornerRadius: 15))

                            }
                        }
                        .buttonStyle(.plain)
                        .padding()
                        Text("This is a simple demo that replicates the UI of the Music app. By using this package, you can achieve a visually appealing combination of a header view and a nav bar.")
                            .font(.callout)
                            .foregroundStyle(.thinMaterial)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                            .padding(.bottom)
                    }
                    .colorScheme(.light)

                }
                .foregroundStyle(.white)
                .padding(.top,-1)
                .headerViewAnchor()
                .titleVisibilityAnchor()
                Spacer().frame(height: 8)
                VStack(spacing: 0){
                    ForEach(0..<15){ index in
                        VStack(spacing: 0){
                            HStack{
                                Color(red: 208/255, green: 63/255, blue: 112/255)
                                    .opacity(0.8)
                                    .aspectRatio(1, contentMode: .fit)
                                    .clipShape(.rect(cornerRadius: 8))
                                    .frame(width: 50, height: 50)
                                    .padding(.vertical, 0)
                                VStack(alignment: .leading, spacing: 0){
                                    Text("Song Title")
                                        .font(.body)

                                    Text("Artist Name")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                        .padding(.top, 2)
                                }
                                Spacer()
                                Image(systemName: "ellipsis.circle.fill")
                                    .font(.title)
                                    .foregroundStyle(.primary, Color(uiColor: .secondarySystemFill))
                            }
                            .padding(.horizontal)
                            Divider()
                                .padding(.vertical,4)
                                .padding(.leading, 74)
                        }
                    }
                }
                Spacer().frame(height: 300)

            }

        }
        .scrollAwareNavBar(
            navBarFadeMode: .threshold,
            navBarFadeThresh: 0.3,
            backButtonDesign: .musicStyle,
            showCustomBackButtonThresh: 0.9
        )
        .scrollAwareTitle("Today’s Hits")
    }
}

#Preview {
    MusicAppView1()
}

