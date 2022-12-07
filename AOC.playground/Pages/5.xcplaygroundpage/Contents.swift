import Foundation

struct Instruction {
    let count: Int
    let from: Int
    let to: Int
}

// Part 1
var stacks = [
    1: ["D", "H", "R", "Z", "S", "P", "W", "Q"],
    2: ["F", "H", "Q", "W", "R", "B", "V"],
    3: ["H", "S", "V", "C"],
    4: ["G", "F", "H"],
    5: ["Z", "B", "J", "G", "P"],
    6: ["L", "F", "W", "H", "J", "T", "Q"],
    7: ["N", "J", "V", "L", "D", "W", "T", "Z"],
    8: ["F", "H", "G", "J", "C", "Z", "T", "D"],
    9: ["H", "B", "M", "V", "P", "W"]
]

let data: [Instruction] = load(file: "input")!
    .components(separatedBy: .newlines)
    .filter { !$0.isEmpty }
    .map {
        $0.components(separatedBy: .decimalDigits.inverted).filter { $0 != "" }
    }
    .map { array in
        let count = Int(array[0])!
        let from = Int(array[1])!
        let to = Int(array[2])!
        return Instruction(count: count, from: from, to: to)
    }

for item in data {
    for _ in 0..<item.count {
        let val = stacks[item.from]!.removeFirst()
        stacks[item.to]?.insert(val, at: 0)
    }
}

var string = ""
for i in 1...9 {
    string += stacks[i]!.first!
}

print(string)

// Part two
// Reset the stacks
stacks = [
    1: ["D", "H", "R", "Z", "S", "P", "W", "Q"],
    2: ["F", "H", "Q", "W", "R", "B", "V"],
    3: ["H", "S", "V", "C"],
    4: ["G", "F", "H"],
    5: ["Z", "B", "J", "G", "P"],
    6: ["L", "F", "W", "H", "J", "T", "Q"],
    7: ["N", "J", "V", "L", "D", "W", "T", "Z"],
    8: ["F", "H", "G", "J", "C", "Z", "T", "D"],
    9: ["H", "B", "M", "V", "P", "W"]
]

for item in data {
    let itemsToMove = Array(stacks[item.from]![0..<item.count])
    stacks[item.from]!.removeFirst(item.count)
    stacks[item.to]!.insert(contentsOf: itemsToMove, at: 0)
}

var stringTwo = ""
for i in 1...9 {
    stringTwo += stacks[i]!.first!
}

print(stringTwo)
