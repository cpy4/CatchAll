import Foundation


struct Capture: Decodable, Identifiable, Encodable {
  let id: Int?
  let content: String
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
