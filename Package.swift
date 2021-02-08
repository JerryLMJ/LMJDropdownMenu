// swift-tools-version:5.0
import PackageDescription

let package = Package(
  name: "LMJDropdownMenu",
  products: [
    .library(name: "LMJDropdownMenu", targets: ["LMJDropdownMenu"]),
  ],
  targets: [
    .target(
      name: "LMJDropdownMenu",
      dependencies: [],
      path: "LMJDropdownMenu"),
  ]
)
