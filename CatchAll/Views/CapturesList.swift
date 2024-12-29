//
//  CapturesList.swift
//  CatchAll
//
//  Created by CJ Pye on 10/25/24.
//

import SwiftUI

struct CapturesList: View {

  @State private var captures: [Capture] = []

  var body: some View {
      List(captures) {
        capture in
           CaptureCard(capture: capture)
      }
    .task {
      captures = await getCapturesFeed()
      print(captures)
    }
  }
}

#Preview {
  CapturesList()
}
