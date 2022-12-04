import Foundation

extension String {
    var numbersSplitByDash: [Int] {
        let components = self.components(separatedBy: "-")
        return Array((Int(components.first!)!)...(Int(components.last!)!))
    }
}

let data = load(file: "input")!.components(separatedBy: .newlines).filter { !$0.isEmpty }.map { $0.components(separatedBy: ",") }

var count = 0
for item in data {
    let arrayOne = item[0].numbersSplitByDash
    let arrayTwo = item[1].numbersSplitByDash

    if arrayOne.count > arrayTwo.count {
        count += Set(arrayTwo).isSubset(of: arrayOne) ? 1 : 0
    } else {
        count += Set(arrayOne).isSubset(of: arrayTwo) ? 1 : 0
    }
}

print(count)

// Part two
var countTwo = 0
for item in data {
    let arrayOne = item[0].numbersSplitByDash
    let arrayTwo = item[1].numbersSplitByDash

    countTwo += Set(arrayTwo).intersection(arrayOne).count > 0 ? 1 : 0
}

print(countTwo)
