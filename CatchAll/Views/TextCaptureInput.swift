//
//  TextCaptureInput.swift
//  CatchAll
//
//  Created by CJ Pye on 12/10/24.
//
import Foundation
import SwiftUI

struct TextCaptureInput: View {
  @State private var textInput: String = ""
  var body: some View {
    HStack {
      Button(action: {}) {
        Image(systemName: "paperclip")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 30, height: 25)
          .foregroundColor(.red)
      }
      TextField("Placeholder", text: $textInput)
        .padding(10)
        .background(
          RoundedRectangle(cornerRadius: 30)
            .stroke(Color.gray, lineWidth: 1))
      Button(action: {
        Task {
          await insertTextCapture()
        }
      }) {
        Image(systemName: "arrow.up")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 30, height: 25)
          .foregroundColor(.red)
      }
    }
  }

  private func insertTextCapture() async {
    guard !textInput.isEmpty else {
      print("Input Field Can't be empty!")
      return
    }
    let textCapture = Capture(id: nil, content: textInput)
    do {
      try await supabase
        .from("vtext_captures")
        .insert(textCapture)
        .execute()
    } catch {
      print("Failed to insert text capture: \(error)")
    }
  }
}

#Preview {
  TextCaptureInput()
}
