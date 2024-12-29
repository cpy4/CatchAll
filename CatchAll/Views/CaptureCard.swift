//
//  CardView.swift
//  CatchAll
//
//  Created by CJ Pye on 12/27/24.
//

import SwiftUI

struct CaptureCard: View {
    let capture: Capture

    var body: some View {
        createCard(capture: capture)
    }
}

private func createCard(
    capture: Capture
) -> some View {
    ZStack {
        Text(String(capture.textContent!))
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 20)
    .background(Color.blue)
    .foregroundColor(Color.black)
    .cornerRadius(10)
    //.frame(maxWidth: .infinity, alignment: .leading)
    //.fixedSize(horizontal: false, vertical: true)
}

#Preview {
    var capture = Capture.sampleData[0]
    var capture2 = Capture.sampleData[1]
    VStack {
        CaptureCard(capture: capture)
        CaptureCard(capture: capture2)
    }
}
