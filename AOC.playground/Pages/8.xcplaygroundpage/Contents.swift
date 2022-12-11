import Foundation

let data = load(file: "input")!.components(separatedBy: .newlines).filter { !$0.isEmpty }

let edgesCount = (data[0].count * 2) + (data.count * 2) - 4
var visibleCount = 0

for (rowIndex, singleRow) in data.enumerated() {
    if rowIndex == 0 || rowIndex == data.count - 1 {
        // Skip these because they are edges
        continue
    }

    print("Row \(rowIndex)")

    for (columnIndex, columnValue) in singleRow.enumerated() {
        if columnIndex == 0 || columnIndex == singleRow.count - 1 {
            // Skip these because they are edges
            continue
        }

        let intValue = Int(String(columnValue))!
        print("\t(\(rowIndex), \(columnIndex)) - \(intValue)")
        outerLoop: while true {
            let l = Array(singleRow[0..<columnIndex])
            let allValuesToLeft = l.compactMap { Int(String($0)) }

            print("\t\tLeft: \(allValuesToLeft)")
            if (allValuesToLeft.allSatisfy { $0 < intValue }) {
                visibleCount += 1
                print("\t\tAdding 1 for left: \(allValuesToLeft)")
                break outerLoop
            }

            let r = Array(singleRow[(columnIndex+1)..<singleRow.count])
            let allValuesToRight = r.compactMap { Int(String($0)) }
            print("\t\tRight: \(allValuesToRight)")
            if (allValuesToRight.allSatisfy { $0 < intValue }) {
                visibleCount += 1
                print("\t\tAdding 1 for right: \(allValuesToRight)")
                break outerLoop
            }

            let allValuesToTop = data[0..<rowIndex].map { Int($0[columnIndex])! }
            print("\t\tTop: \(allValuesToTop)")
            if (allValuesToTop.allSatisfy { $0 < intValue }) {
                visibleCount += 1
                print("\t\tAdding 1 for top: \(allValuesToTop)")
                break outerLoop
            }

            let allValuesToBottom = data[rowIndex+1..<data.count].map { Int($0[columnIndex])! }
            print("\t\tBottom: \(allValuesToBottom)")
            if (allValuesToBottom.allSatisfy { $0 < intValue }) {
                visibleCount += 1
                print("\t\tAdding 1 for bottom: \(allValuesToBottom)")
                break outerLoop
            }

            break
        }
    }
}

print(visibleCount + edgesCount)

// Part two
var highestMultiple = 0
for (rowIndex, singleRow) in data.enumerated() {
    print("Row \(rowIndex)")

    for (columnIndex, columnValue) in singleRow.enumerated() {
        let intValue = Int(String(columnValue))!
        print("\t(\(rowIndex), \(columnIndex)) - \(intValue)")
        let l = Array(singleRow[0..<columnIndex])
        var left: [Int] = l.compactMap { Int(String($0)) }.reversed()
        var countLeft = 0
        var continueLeft = !left.isEmpty
        while continueLeft {
            guard rowIndex != 0 && columnIndex != 0 else {
                continueLeft = false
                continue
            }
            countLeft += 1
            let val = left.removeFirst()
            if val <= intValue {
                if val == intValue {
                    continueLeft = false
                }
            } else {
                continueLeft = false
            }

            if left.isEmpty {
                continueLeft = false
            }
        }

        print("\t\tLeft: \(countLeft)")

        let r = Array(singleRow[(columnIndex+1)..<singleRow.count])
        var right = r.compactMap { Int(String($0)) }
        var countRight = 0
        var continueRight = !right.isEmpty
        while continueRight {
            guard rowIndex != 0 && columnIndex != 0 else {
                continueRight = false
                continue
            }
            countRight += 1
            let val = right.removeFirst()
            if val <= intValue {
                if val == intValue {
                    continueRight = false
                }
            } else {
                continueRight = false
            }

            if right.isEmpty {
                continueRight = false
            }
        }
        print("\t\tRight: \(countRight)")

        var top: [Int] = data[0..<rowIndex].map { Int($0[columnIndex])! }.reversed()
        var countTop = 0
        var continueTop = !top.isEmpty
        print("\t\tTop1: \(top)")
        while continueTop {
            guard rowIndex != 0 && columnIndex != 0 else {
                continueTop = false
                continue
            }
            countTop += 1
            let val = top.removeFirst()
            if val <= intValue {
                if val == intValue {
                    continueTop = false
                }
            } else {
                continueTop = false
            }

            if top.isEmpty {
                continueTop = false
            }
        }
        print("\t\tTop: \(countTop)")

        var bottom = data[rowIndex+1..<data.count].map { Int($0[columnIndex])! }
        var countBottom = 0
        var continueBottom = !bottom.isEmpty
        while continueBottom {
            guard rowIndex != 0 && columnIndex != 0 else {
                continueBottom = false
                continue
            }
            countBottom += 1
            let val = bottom.removeFirst()
            if val <= intValue {
                if val == intValue {
                    continueBottom = false
                }
            } else {
                continueBottom = false
            }

            if bottom.isEmpty {
                continueBottom = false
            }
        }
        print("\t\tBottom: \(countBottom)")

        let multiple = countLeft * countRight * countTop * countBottom
        print("\t\tMultiple: \(multiple)")
        highestMultiple = max(highestMultiple, multiple)
    }
}

print(highestMultiple)
