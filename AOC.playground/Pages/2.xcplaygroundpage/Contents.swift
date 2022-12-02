import Foundation

enum Play {
    case rock
    case paper
    case scissors

    var value: Int {
        switch self {
        case .rock: return 1
        case .paper: return 2
        case .scissors: return 3
        }
    }

    init?(theirValue: String) {
        switch theirValue {
        case "A": self = .rock
        case "B": self = .paper
        case "C": self = .scissors
        default: return nil
        }
    }

    init?(mineValue: String) {
        switch mineValue {
        case "X": self = .rock
        case "Y": self = .paper
        case "Z": self = .scissors
        default: return nil
        }
    }
}

enum Outcome: String {
    case lose = "X"
    case draw = "Y"
    case win = "Z"
}

func calculateOne(mine: Play, theirs: Play) -> Int {
    let drawValue = 3
    let winValue = 6
    let lostValue = 0

    if mine == theirs {
        return mine.value + drawValue
    }

    var mineWins = false
    if mine == .rock && theirs == .scissors {
        mineWins = true
    } else if mine == .paper && theirs == .rock {
        mineWins =  true
    } else if mine == .scissors && theirs == .paper {
        mineWins = true
    }

    if mineWins {
        return mine.value + winValue
    } else {
        return mine.value + lostValue
    }
}

func calculateTwo(theirs: Play, outcome: Outcome) -> Int {
    if outcome == .win {
        switch theirs {
        case .rock: return calculateOne(mine: .paper, theirs: theirs)
        case .paper: return calculateOne(mine: .scissors, theirs: theirs)
        case .scissors: return calculateOne(mine: .rock, theirs: theirs)
        }
    } else if outcome == .lose {
        switch theirs {
        case .rock: return calculateOne(mine: .scissors, theirs: theirs)
        case .paper: return calculateOne(mine: .rock, theirs: theirs)
        case .scissors: return calculateOne(mine: .paper, theirs: theirs)
        }
    } else if outcome == .draw {
        return calculateOne(mine: theirs, theirs: theirs)
    }

    return 0
}

let input = load(file: "input")!.components(separatedBy: .newlines).map { $0.components(separatedBy: .whitespaces) }.filter { $0.count == 2 }

// Part one
var score = 0
for pair in input {
    guard let mine = Play(mineValue: pair[1]) else { continue }
    guard let theirs = Play(theirValue: pair[0]) else { continue }
    let thisScore = calculateOne(mine: mine, theirs: theirs)
    score += thisScore
}

print(score)

// Part two
var partTwoScore = 0
for pair in input {
    guard let theirs = Play(theirValue: pair[0]) else { continue }
    guard let outcome = Outcome(rawValue: pair[1]) else { continue }
    let thisScore = calculateTwo(theirs: theirs, outcome: outcome)
    partTwoScore += thisScore
}

print(partTwoScore)
