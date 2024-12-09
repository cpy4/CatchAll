//
//  ContentView.swift
//  CatchAll
//
//  Created by CJ Pye on 10/25/24.
//

import SwiftUI

struct ContentView: View {
  @ObserveInjection var inject
  var body: some View {

    VStack {
      CapturesList()
      CatchAllButton()
    }
    .padding()
    .enableInjection()
  }
}

#Preview {
  ContentView()
}
