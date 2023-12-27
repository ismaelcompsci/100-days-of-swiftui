import Cocoa

struct BankAccount {
    // readeable but not writable
    private(set) var funds = 0

    mutating func deposit(ammount: Int) {
        funds += ammount
    }

    mutating func withdraw(amount: Int) -> Bool {
        if funds > amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

var account = BankAccount()
account.deposit(ammount: 100)

let success = account.withdraw(amount: 200)

if success {
    print("Withdrew money successfully")
} else {
    print("Failed to get the money")
}

enum School {
    static var studentCount = 0

    static func add(student: String) {
        print("\(student) joined the school.")
        studentCount += 1
    }
}

School.add(student: "Taylor Swift")
print(School.studentCount)

enum AppData {
    static let version = "1.3 beta 2"
    static let saveFilename = "settings.json"
    static let homeURL = "https://www.hackingwith.com"
}

print(AppData.version)

struct Employee {
    let username: String
    let password: String

    static let example = Employee(username: "cfderight", password: "h44iiajs;da")
}

// Checkpoint 6
struct Car {
    let model: String
    let numberSeats: Int
    private var currentGear: Int

    init(model: String, numberSeats: Int, currentGear: Int = 1) {
        self.model = model
        self.numberSeats = numberSeats
        self.currentGear = currentGear
    }

    mutating func changeGear(gear: Int) -> Bool {
        let range = 1 ... 10

        if !(range ~= gear) {
            return false
        } else {
            currentGear = gear
            return true
        }
    }

    func getCurrentGear() -> Int {
        return currentGear
    }
}

let myCar = Car(model: "Camera", numberSeats: 4)
