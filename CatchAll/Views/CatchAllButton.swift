//
//  CatchAllButton.swift
//  CatchAll
//
//  Created by CJ Pye on 10/26/24.
//

import SwiftUI

let supabase = SupabaseManager.shared.client

struct Capture: Decodable {
  let id: Int
  let content: String
}

struct CatchAllButton: View {
  @State private var visible = false
  @State private var captures: [Capture] = []

  var body: some View {
    ZStack {
      Button(action: {
        withAnimation { visible.toggle() }
        print(captures)
      }) {
        Image(systemName: "plus.app.fill")  // Replace with desired SF Symbol
          .resizable()  // Allows resizing of the icon
          .aspectRatio(contentMode: .fit)
          .frame(width: 70, height: 70)
          .foregroundColor(.teal)
      }
      if visible {
        Button(action: {}) {
          Image(systemName: "camera.circle.fill")  // Replace with desired SF Symbol
            .resizable()  // Allows resizing of the icon
            .aspectRatio(contentMode: .fit)
            .frame(width: 60, height: 60)
            .foregroundColor(.black)
        }
        .offset(x: 65, y: -45)
        .transition(.move(edge: .bottom))

        Button(action: {}) {
          Image(systemName: "document.circle.fill")  // Replace with desired SF Symbol
            .resizable()  // Allows resizing of the icon
            .aspectRatio(contentMode: .fit)
            .frame(width: 60, height: 60)
            .foregroundColor(.blue)
        }
        .offset(x: 0, y: -70)
        .transition(.move(edge: .bottom))

        Button(action: {}) {
          Image(systemName: "bubble.circle.fill")  // Replace with desired SF Symbol
            .resizable()  // Allows resizing of the icon
            .aspectRatio(contentMode: .fit)
            .frame(width: 60, height: 60)
            .foregroundColor(.green)
        }
        .offset(x: -65, y: -45)
        .transition(.move(edge: .bottom))
      }
    }
    .padding()
    .task {
      do {
        captures =
          try await supabase
          .from("vtext_captures")
          .select()
          .execute()
          .value
      } catch {
        print("Error fetching captures: \(error)")
      }
    }
  }
}

#Preview {
  CatchAllButton()
}
