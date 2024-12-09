// swift-tools-version:5.7
import Foundation
import PackageDescription

let package = Package(
  name: "CatchAll",
  platforms: [
    .iOS(.v13),
    .macOS(.v10_15),
  ],
  products: [
    .library(
      name: "CatchAll",
      targets: ["CatchAll"])
  ],
  dependencies: [
    .package(url: "https://github.com/supabase-community/supabase-swift.git", from: "2.24.0"),
    .package(url: "https://github.com/krzysztofzablocki/Inject.git", from: "1.5.2"),
    .package(url: "https://github.com/thebarndog/swift-dotenv.git", from: "2.0.0"),
  ],
  targets: [
    .target(
      name: "CatchAll",
      dependencies: [
        .product(name: "Supabase", package: "supabase-swift"),
        .product(name: "Inject", package: "Inject"),
        .product(name: "SwiftDotenv", package: "swift-dotenv"),
      ],
      path: "CatchAll"
    ),
    .testTarget(
      name: "CatchAllTests",
      dependencies: ["CatchAll"],
      path: "CatchAllTests"
    ),
  ]
)
