import Foundation
import SwiftUI

struct Capture: Decodable, Identifiable, Encodable {
    let id: Int?
    let type: CaptureType
    let textContent: String?
    let fileData: Data?
    let fileName: String?
    
    init(id: Int? = nil,
         type: CaptureType = .notset,
         textContent: String? = nil,
         fileData: Data? = nil,
         fileName: String? = nil) {
        self.id = id
        self.type = type
        self.textContent = textContent
        self.fileData = fileData
        self.fileName = fileName
    }
}

enum CaptureType: Decodable, Encodable {
  case notset
  case text
  case photo
  case file
  case aichat
}

extension Capture {
    static let sampleData: [Capture] =
    [
        Capture(id: 1, textContent: "Design stuff this is some test text lol smiley face"),
        Capture(id: 2, textContent: "App Dev"),
        Capture(id: 3, textContent: "Web Dev")
    ]
}

func getCapturesFeed() async -> [Capture] {
  var captures: [Capture]
  do {
    captures =
      try await supabase
      .from("vtext_captures")
      .select()
      .execute()
      .value
   return captures
      //return Capture.sampleData
  } catch {
    print("Error fetching captures: \(error)")
    return []
  }
}

func insertTextCapture(textInput: String) async {
    guard !textInput.isEmpty else {
      print("Input Field Can't be empty!")
      return
    }
    let textCapture = Capture(textContent: textInput)
    do {
      try await supabase
        .from("vtext_captures")
        .insert(textCapture)
        .execute()
    } catch {
      print("Failed to insert text capture: \(error)")
    }
  }

func insertFileCapture(file: Data, name: String) async {
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
