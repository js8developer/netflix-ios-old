//
//  ScoreView.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/13/22.
//

import SwiftUI

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(voteAverage: 8.2)
    }
}



struct ScoreView: View {
    
    var voteAverage: Double
  
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.clear)
                .frame(width: 40, height: 40)
                .overlay (
                    Circle()
                        .trim(from: 0, to: CGFloat(voteAverage * 0.1))
                        .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                        .fill(voteAverage <= 3 ? Color.red : (voteAverage < 7 ? Color.orange : Color.green) )
            )
            Text(String(format: "%.1f", voteAverage)).fontWeight(.semibold)
        }
    }
}

