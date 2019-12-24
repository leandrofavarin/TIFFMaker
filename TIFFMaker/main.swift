#!/usr/bin/swift

import Foundation
import AppKit

enum ScriptError : Error {
  case noArguments
  case notTiffRepresentable
  case unknown
}


guard let fileName = CommandLine.arguments.last else {
  throw ScriptError.noArguments
}
print("filename is \(fileName)")

let image = NSImage()
for _ in 1...3 {
  let imageReps = NSBitmapImageRep.imageReps(withContentsOfFile: fileName)
  guard let firstImageRep = imageReps?.first else {
    throw ScriptError.unknown
  }
  image.addRepresentation(firstImageRep)
}

guard let data = image.tiffRepresentation else {
  throw ScriptError.notTiffRepresentable
}

try data.write(to: URL(fileURLWithPath: "\(fileName).tiff"))
