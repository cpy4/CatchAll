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
