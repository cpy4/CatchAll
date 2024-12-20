//
//  CatchAllButton.swift
//  CatchAll
//
//  Created by CJ Pye on 10/26/24.
//
import Foundation
import SwiftUI

enum CaptureType {
  case notset
  case text
  case photo
  case file
  case aichat
}

struct CatchAllButton: View {
  @State private var mainButtonVisible = true
  @State private var isButtonVisible = false
  @Binding var captureType: CaptureType
  @State private var importing = false
  @State private var fileName: String?
  @State private var selectedFile: Data?

  var body: some View {
    ZStack {
      if mainButtonVisible {
        createButton(systemName: "plus.circle.fill", color: .teal, size: 70) {
          withAnimation { isButtonVisible.toggle() }
        }
      }
      if isButtonVisible {
        createButton(systemName: "camera.circle.fill", color: .red, size: 60) {
          if captureType == .photo { captureType = .notset } else { captureType = .photo }
        }
        .offset(x: 65, y: -45)
        .transition(.asymmetric(insertion: .offset(x: -65, y: 45), removal: .offset(x: -65, y: 45)))
        .animation(.easeInOut(duration: 0.05), value: isButtonVisible)

        createButton(systemName: "document.circle.fill", color: .blue, size: 60) {
          if captureType == .file {
            captureType = .notset
          } else {
            captureType = .file
            importing = true
          }
        }
        .fileImporter(
          isPresented: $importing,
          allowedContentTypes: [.plainText, .pdf, .image]
        ) { result in
          switch result {
          case .success(let file):
            if file.startAccessingSecurityScopedResource() {
              do {
                //let path = file.absoluteString
                fileName = file.lastPathComponent
                print("File name: \(fileName)")
                selectedFile = try Data(contentsOf: file)
              } catch {
                print("Error reading file data: \(error)")
              }
            }
            Task {
                await insertFileCapture(file: selectedFile!, name: fileName!)
            }
          case .failure(let error):
            print(error.localizedDescription)
          }
        }
        .offset(x: 0, y: -75)
        .transition(.asymmetric(insertion: .offset(x: 0, y: 70), removal: .offset(x: 0, y: 70)))
        .animation(.easeInOut(duration: 0.05), value: isButtonVisible)

        createButton(systemName: "bubble.circle.fill", color: .green, size: 60) {
          if captureType == .text {
            captureType = .notset
          } else {
            captureType = .text
            mainButtonVisible = false
            isButtonVisible = false
          }
        }
        .offset(x: -65, y: -45)
        .transition(.asymmetric(insertion: .offset(x: 65, y: 45), removal: .offset(x: 65, y: 45)))
        //.animation(.easeInOut(duration: 1.05), value: isButtonVisible)
      }
      if !mainButtonVisible {
        createButton(systemName: "x.circle.fill", color: .red, size: 20) {
          withAnimation {
            mainButtonVisible = true
            captureType = .notset
          }
        }
      }
    }
    .padding()
  }
}

private func createButton(
  systemName: String, color: Color, size: CGFloat, action: @escaping () -> Void = {}
) -> some View {
  Button(action: action) {
    Image(systemName: systemName)
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(width: size, height: size)
      .foregroundColor(color)
  }
}

private func insertFileCapture(file: Data, name: String) async {
  print("Uploading file to path: \(name)")
  do {
    try await supabase.storage
      .from("files")
      .upload(
        "useruploads/\(name)",
        data: file
      )
  } catch {
    print("Failed to insert file capture: \(error)")
  }
}

#Preview {
  // Create a state variable to hold the capture type
  @Previewable @State var previewCaptureType: CaptureType = .notset

  // Return the CatchAllButton with the binding
  return CatchAllButton(captureType: $previewCaptureType)
}
