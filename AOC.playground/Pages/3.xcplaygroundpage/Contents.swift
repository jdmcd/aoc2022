import Foundation

extension Character {
    static let alphabetValue = zip("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", 1...52).reduce(into: [:]) { $0[$1.0] = $1.1 }
    var letterValue: Int? { Self.alphabetValue[self] }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

let data = load(file: "input")!.components(separatedBy: .newlines).filter { !$0.isEmpty }

// Part 1
var total = 0
for rucksack in data {
    let count = rucksack.count / 2
    let compartmentOne = rucksack.prefix(count)
    let compartmentTwo = rucksack.suffix(count)
    let intersection = Set(compartmentOne).intersection(Set(compartmentTwo))
    total += intersection.compactMap(\.letterValue).sum
}

print(total)

// Part 2
var partTwoTotal = 0
for group in data.chunked(into: 3) {
    let intersection = Set(group[0]).intersection(Set(group[1])).intersection(Set(group[2]))
    partTwoTotal += intersection.compactMap(\.letterValue).sum
}

print(partTwoTotal)
