import Foundation

let data = load(file: "input")!.filter { !$0.isWhitespace && !$0.isNewline }

var array = [String]()
for letter in data {
    if array.count < 4 {
        array.append(String(letter))
        continue
    }

    let lastFour = array[array.count-4..<array.count]
    if Set(lastFour).count == lastFour.count {
        // All unique, stop
        print(array.count)
        break
    }

    array.append(String(letter))
}

var arrayTwo = [String]()
for letter in data {
    if arrayTwo.count < 14 {
        arrayTwo.append(String(letter))
        continue
    }

    let lastFour = arrayTwo[arrayTwo.count-14..<arrayTwo.count]
    if Set(lastFour).count == lastFour.count {
        // All unique, stop
        print(arrayTwo.count)
        break
    }

    arrayTwo.append(String(letter))
}
