import Cocoa

var greeting = "Hello, playground"

func greetUser() {
    print("Hi threre")
}

greetUser()
var greetCopy = greetUser

greetCopy()

let sayHello = {
    print("Hi there!")
}

sayHello()

let sayHelloParams = { (name: String) -> String in "hi \(name)" }

sayHelloParams("John")

let team = ["Gloria", "Piper", "Tasha", "Ash"]
let sortedTeam = team.sorted()
print(sortedTeam)

func captinFirstSorted(name1: String, name2: String) -> Bool {
    if name1 == "Tasha" {
        return true
    } else if name2 == "Tasha" {
        return false
    }

    return name1 < name2
}

//
// let captainFirstTeam = team.sorted(by: captinFirstSorted)
// print(captainFirstTeam)

let captainFirstTeam = team.sorted(by: { (name1: String, name2: String) -> Bool in
    if name1 == "Tasha" {
        return true
    } else if name2 == "Tasha" {
        return false
    }

    return name1 < name2
})

let captainFirstTeam_colosure = team.sorted { a, b in
    if a == "Tasha" {
        return true
    } else if b == "Tasha" {
        return false
    }

    return a < b
}

let tOnly = team.filter { $0.hasPrefix("T") }
print(tOnly)

func doImportantWork(first: () -> Void, second: () -> Void, third: () -> Void) {
    print("About to start first work.")
    first()
    print("About to start second work.")
    second()
    print("About to start third work.")
    third()
}

doImportantWork {
    print("This is the first work.")
} second: {
    print("This is the second work.")
} third: {
    print("This is the third work.")
}

let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

luckyNumbers.filter {
    $0 % 2 != 0
}.sorted {
    $0 < $1
}.map {
    "\($0) is a lucky numnber"
}.map {
    print("\($0)\n")
}
