//
//  CardView.swift
//  CatchAll
//
//  Created by CJ Pye on 12/27/24.
//

import SwiftUI

struct CaptureCard: View {
    var message: String
    var isCurrentUser: Bool

    var body: some View {
        HStack {
            if isCurrentUser {
                Spacer()
            }
            Text(message)
                .padding(10)
                .background(isCurrentUser ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(isCurrentUser ? Color.white : Color.black)
                .cornerRadius(10)
                .padding(isCurrentUser ? .leading : .trailing, 50)
            if !isCurrentUser {
                Spacer()
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

private func createCard(
    capture: Capture
) -> some View {
    ZStack {
      //  capture.textContent
    }
}

#Preview {
    VStack {
        CaptureCard(message: "Hello, how are you?", isCurrentUser: false)
        CaptureCard(message: "I'm good, thanks! How about you?", isCurrentUser: true)
    }
}
