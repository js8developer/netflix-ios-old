//
//  ShimmerView.swift
//  Netflix-Remix
//
//  Created by Jason Schneider on 7/12/22.
//

import SwiftUI

struct ShimmerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                ShimmerView()
                    .frame(width: 100, height: 100)

                ShimmerView()
                    .frame(height: 20)

                ShimmerView()
                    .frame(height: 50)

            }
            .padding()
        }
    }
}


struct ShimmerView: View {

    @State private var opacity: Double = 0.25

    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(Color.darkGray)
            .opacity(opacity)
            .transition(.opacity)
            .onAppear {
                let baseAnimation = Animation.easeInOut(duration: 0.9)
                let repeated = baseAnimation.repeatForever(autoreverses: true)
                withAnimation(repeated) {
                    self.opacity = 1
                }
        }
    }
}

