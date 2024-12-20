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
    List {
      ForEach(captures) { capture in
        Text(capture.content)
      }
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
