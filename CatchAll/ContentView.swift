//
//  ContentView.swift
//  CatchAll
//
//  Created by CJ Pye on 10/25/24.
//

import SwiftUI

struct ContentView: View {
  @ObserveInjection var inject
  @State private var captureType: CaptureType = .notset

  var body: some View {

    VStack {
      CapturesList()
      if captureType == .text { TextCaptureInput() }
      CatchAllButton(captureType: $captureType)
    }
    .padding()
    .enableInjection()
    .background(Color(.systemBackground)) // Adjusts to light/dark mode
    //.foregroundColor(Color(.label))
  }
}

#Preview {
  ContentView()
}
