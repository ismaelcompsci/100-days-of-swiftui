import Cocoa

func printTimesTable(for number: Int, end: Int = 12) {
    for i in 1 ... end {
        print("\(i) x \(number) = \(i * number)")
    }
}

printTimesTable(for: 2, end: 12)
printTimesTable(for: 1)

var words = ["HELLO", "NO", "YES"]

print(words.count)
words.removeAll(keepingCapacity: true)

enum PasswordError: Error {
    case short, obivious
}

func checkPassword(_ password: String) throws -> String {
    if password.count < 5 { throw PasswordError.short }
    if password == "12345" { throw PasswordError.obivious }

    if password.count < 8 {
        return "OK"
    } else if password.count < 10 {
        return "Good"
    } else {
        return "Excellent"
    }
}

do {
    let res = try checkPassword("12345")
    print("Password string: \(res)")
} catch PasswordError.short {
    print("Please use a longer password")
} catch PasswordError.obivious {
    print("Pasword is too obivious")
} catch {
    print("There was an error \(error.localizedDescription)")
}

enum SquareRootError: Error {
    case outOfBounds, noRoot
}

func squareRoot(of number: Int) throws -> Int {
    if number < 1 || number > 10_000 { throw SquareRootError.outOfBounds }

    var i = 1
    var result = 1

    while result <= number {
        i += 1
        result = i * i
    }
    i = i - 1
    if (i * i) != number { throw SquareRootError.noRoot }

    return i
}

do {
    let result = try squareRoot(of: 624)
    print("result: \(result)")
} catch SquareRootError.outOfBounds {
    print("Number out of bounds")
} catch SquareRootError.noRoot {
    print("failed to find the square root")
} catch {
    print("something went wrong: \(error.localizedDescription)")
}
