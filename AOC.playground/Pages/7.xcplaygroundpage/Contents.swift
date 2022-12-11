import Foundation

//class File {
//    let name: String
//    let size: Int
//    let directory: String
//
//    init(name: String, size: Int, directory: String) {
//        self.name = name
//        self.size = size
//        self.directory = directory
//    }
//}
//
//class Directory {
//    let name: String
//    let parent: Directory?
//    var files: [File]
//    var fileSizeCount: Int {
//        return files.map(\.size).reduce(0, +)
//    }
//
//    init(name: String, parent: Directory?, files: [File]) {
//        self.name = name
//        self.parent = parent
//        self.files = files
//    }
//}

let data = load(file: "input")!.components(separatedBy: .newlines).filter { !$0.isEmpty }

var currentPath: [String] = []
var sizes: [String: Int] = [:]

for item in data {
    if item.first == "$" {
        // It's a command
        if item.contains("cd") {
            let path = item.components(separatedBy: .whitespaces).last!
            if path == "/" {
                currentPath = ["/"]
            } else if path == ".." {
                currentPath = currentPath.dropLast()
            } else {
                currentPath.append(path)
            }

            if currentPath.isEmpty {
                currentPath = ["/"]
            }

            continue
        } else {
            // Must be ls, skip entirely because we don't need to change the path here
            continue
        }
    }

    if !item.contains("dir") {
        print(currentPath.joined(separator: "/"))
        let split = item.components(separatedBy: .whitespaces)
        let size = Int(split[0])!
        print("\tFile \(split[1]) with size \(size)")
        var pathString = ""
        for pathComponent in currentPath {
            pathString += "\(pathComponent)\(pathComponent == "/" ? "" : "/")"
            if let existing = sizes[pathString] {
                sizes[pathString] = existing + size
                print("\t\tAdding \(size) to \(pathString), total is now \(sizes[pathString]!)")
            } else {
                sizes[pathString] = size
                print("\t\tAdding \(size) to \(pathString), total is now \(sizes[pathString]!)")
            }
        }
    }
}

print(sizes.values.filter { $0 < 100000 }.sum)

// Part two
let entireSystemAmount = sizes["/"]!
let free = 70_000_000 - entireSystemAmount
var partTwoAnswer = entireSystemAmount
for (_, value) in sizes {
    if value > (30_000_000 - free) {
        partTwoAnswer = min(partTwoAnswer, value)
    }
}

print(partTwoAnswer)
