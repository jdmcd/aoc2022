import Foundation

// Part 1
let input = load(file: "input")!
let splitInput = input
    .components(separatedBy: "\n\n")
    .map {
        $0.components(separatedBy: "\n").compactMap {
            Int($0)
        }
    }

let maxCals = splitInput.max(by: { a, b in a.sum < b.sum })!.sum
print(maxCals)

// Part 2
let topThreeMaxCals = Array(splitInput.sorted(by: { a, b in a.sum > b.sum }).prefix(3)).map { $0.sum }.sum
print(topThreeMaxCals)
