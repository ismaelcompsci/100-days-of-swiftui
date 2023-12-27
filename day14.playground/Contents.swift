import Cocoa

let opposites = ["Mario": "Wario", "Luigi": "Waluigi"]
let peachOpposite = opposites["Peach"]

if let marioOpposite = opposites["Mario"] {
    print("Mario's opposite is \(marioOpposite)")
}

var username: String?

if let unwrappedName = username {
    print("We got a user: \(unwrappedName)")
} else {
    print("The optional was empty.;")
}

func square(number: Int) -> Int {
    number * number
}

var number: Int?

if let unwrappedNumber = number {
    print(square(number: unwrappedNumber))
}

func printSquare(of number: Int?) {
    guard let number = number else {
        print("Missing input")
        return
    }

    print("\(number) x \(number) is \(number * number)")
}

let captains = [
    "Enterprise": "Picard",
    "Voyager": "Janeway",
    "Defiant": "Sisko"
]

let new = captains["Serenity"] ?? "N/A"

let tvShows = ["Archer", "Babylon 5", "Ted Lasso"]

let favorite = tvShows.randomElement() ?? "None"

struct Book {
    let title: String
    let author: String?
}

let book = Book(title: "beowulf", author: nil)
let author = book.author ?? "Unknown"
print("Author: \(author)")

let input = ""
let numberq = Int(input) ?? 0

print(numberq)

let names = ["Arya", "Bran", "Robb", "Sansa"]

let chosen = names.randomElement()?.uppercased() ?? "No one"

struct BookD {
    let title: String
    let author: String?
}

var books: BookD?
let authorD = books?.author?.first?.uppercased() ?? "A"
print(author)

enum UserError: Error {
    case badID, networkFailed
}

func getUser(id: Int) throws -> String {
    throw UserError.networkFailed
}

if let user = try? getUser(id: 23) {
    print("User: \(user)")
}

let user = (try? getUser(id: 23)) ?? "Anon"
print("Anon")

// Checkpoint 9

func randomNumbers(numbers: [Int]?) -> Int {
    return numbers?.randomElement() ?? Int.random(in: 1 ... 100)
}

var nums: [Int]?
var numbers = [2, 4, 5, 5]
print(randomNumbers(numbers: nums))
print(randomNumbers(numbers: numbers))
