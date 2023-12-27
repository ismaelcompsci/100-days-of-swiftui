import Cocoa

protocol Vehicle {
    var name: String { get }
    var currentPassangers: Int { get set }

    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}

struct Car: Vehicle {
    let name = "Car"
    var currentPassangers = 1

    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }

    func travel(distance: Int) {
        print("I'm driving \(distance)mi")
    }

    func openSunroof() {
        print("It's a nice day!")
    }
}

struct Bicycle: Vehicle {
    let name = "Bicycle"
    var currentPassangers = 1

    func estimateTime(for distance: Int) -> Int {
        distance / 10
    }

    func travel(distance: Int) {
        print("I'm cycling \(distance)mi")
    }
}

func commute(distance: Int, using vehicle: Vehicle) {
    if vehicle.estimateTime(for: distance) > 100 {
        print("Thats tooo slow!")
    } else {
        vehicle.travel(distance: distance)
    }
}

func getTravelEstimates(using vehicles: [Vehicle], distance: Int) {
    for vehicle in vehicles {
        let estimate = vehicle.estimateTime(for: distance)
        print("\(vehicle.name): \(estimate) hours to travel \(distance)mi")
    }
}

let car = Car()
commute(distance: 100, using: car)

let bike = Bicycle()
commute(distance: 50, using: bike)

getTravelEstimates(using: [car, bike], distance: 120)

protocol View {}

func getRandomNumber() -> some Equatable {
    Int.random(in: 1 ... 6)
}

func getRandomBool() -> some Equatable {
    Bool.random()
}

print(getRandomNumber() == getRandomNumber())

var quote = "    The truth is rarely pure and never simple "

let trimmed = quote.trimmingCharacters(in: .whitespacesAndNewlines)

extension String {
    var lines: [String] {
        components(separatedBy: .newlines)
    }

    func trimmed() -> String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }

    mutating func trim() {
        self = trimmed()
    }
}

var trimmed2 = quote.trimmed()

extension Collection {
    var isNotEmpty: Bool {
        isEmpty == false
    }
}

let guests = ["Mario", "Luigi", "Peach"]

if guests.isNotEmpty {
    print("Guests count: \(guests.count)")
}

protocol Person {
    var name: String { get }
    func sayHello()
}

extension Person {
    func sayHello() {
        print("Hi, I'm \(name)")
    }
}

struct Employee: Person {
    let name: String
}

let taylor = Employee(name: "Taylor Swift")
taylor.sayHello()

// Checkpoints 8

protocol Building {
    var rooms: Int { get set }
    var cost: Int { get set }
    var estateAgent: String { get }

    func summary()
}

struct House: Building {
    var rooms: Int
    var cost: Int
    var estateAgent: String

    func summary() {
        print("The House cost $\(cost), has \(rooms) rooms and it was sold by \(estateAgent)")
    }
}

struct Office: Building {
    var rooms: Int
    var cost: Int
    var estateAgent: String

    func summary() {
        print("The Office cost $\(cost), has \(rooms) rooms and it was sold by \(estateAgent)")
    }
}

let myHouse = House(rooms: 4, cost: 100000, estateAgent: "Taylor Swift")

let myOffice = Office(rooms: 100, cost: 500000, estateAgent: "John Doe")
