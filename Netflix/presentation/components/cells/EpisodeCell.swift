//
//  EpisodeCell.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/13/22.
//

import SwiftUI


//struct EpisodeCell_Previews: PreviewProvider {
//    static var previews: some View {
//        EpisodeCell()
//    }
//}


struct EpisodeCell: View {
    
    var episode: Episode
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            ZStack(alignment: .center) {
                Group {
                    if episode.stillUrl != nil {
                        AsyncImage(url: episode.stillUrl!,
                                   configuration: {AnyView($0.resizable())},
                                   defaultView: {
                                    AnyView(
                                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                                            .fill(Color.darkGray)
                                    )
                        }
                        )
                            .frame(width: 150, height: 90)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(16)
                    } else {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color.darkGray)
                            .frame(width: 150, height: 90)
                    }
                }
            }
            VStack(alignment: .leading) {
                Text(episode.name ?? "").font(.system(size: 20, weight: .semibold))
                Text("Episode \(episode.episodeNumber)").font(.system(size: 14, weight: .medium))
                Text(episode.overview ?? "")
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 10, weight: .medium))
                    .padding(.top, 8)
            }
            
            Spacer(minLength: 0)
        }
        .frame(height: 100)
        
    }
}
