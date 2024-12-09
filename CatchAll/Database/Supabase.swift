// SupabaseManager.swift

import Foundation
import Supabase
import SwiftDotenv

class SupabaseManager {
  static let shared = SupabaseManager()

  let client: SupabaseClient

  private init() {
    // Initialize the Supabase client with your URL and API key

    client = SupabaseClient(
      supabaseURL: URL(string: "http://127.0.0.1:54321")!,
      supabaseKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0"
        // options: SupabaseClientOptions(
        //   db: .init(
        //     // Provide a custom schema. Defaults to "public".
        //     schema: "dev"
        //   )
        // )
    )

  }
}
