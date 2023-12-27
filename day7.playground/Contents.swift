import Cocoa

func showWelcome() {
    print("Welcome to my app!")
    print("Hello how are you doing")
}

func printTimeTables(number: Int) {
    for i in 1...12 {
        print("\(i) * \(number) = \(i * number)")
    }
}

printTimeTables(number: 5)

let root = sqrt(169)
print(root)

func rollDice() -> Int {
    return Int.random(in: 1...6)
}

let result = rollDice()
print(result)

func sameLetters(a: String, b: String) -> Bool {
    return a.sorted() == b.sorted()
}

let isSame = sameLetters(a: "abc", b: "cba")
print(isSame)

func pythoagoras(a: Double, b: Double) -> Double {
    return sqrt(a * a + b * b)
}

let c = pythoagoras(a: 3, b: 4)
print(c)

func getUser() -> (firstName: String, lastName: String) {
    ("Taylor",  "Swift")
}

let user = getUser()
print("Name: \(user.firstName) \(user.lastName)")


func isUpppercase(_ string: String) ->Bool {
    string == string.uppercased()
}


let _result = isUpppercase("HELLO")
