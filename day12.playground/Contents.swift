import Cocoa

class Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var newGame = Game()

newGame.score += 10

class Employee {
    let hours: Int

    init(hours: Int) {
        self.hours = hours
    }

    func printSummary() {
        print("I work for \(hours) a day.")
    }
}

final class Developer: Employee {
    func work() {
        print("I'm writing code for \(hours) hours.")
    }

    override func printSummary() {
        print("I'm a developer who will sometimes work \(hours) hours a day, buto other times I don't")
    }
}

final class Manager: Employee {
    func work() {
        print("I'm going to meetings for \(hours) hours.")
    }
}

let robert = Developer(hours: 8)
let joseph = Manager(hours: 10)

robert.work()
joseph.work()

robert.printSummary()

class Vehicle {
    let isElectric: Bool

    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}

class Car: Vehicle {
    let isConvertible: Bool

    init(isElectric: Bool, isConvertible: Bool) {
        self.isConvertible = isConvertible

        super.init(isElectric: isElectric)
    }
}

let teslaX = Car(isElectric: true, isConvertible: false)

class User {
    var username = "Anonymous"

    func copy() -> User {
        let user = User()
        user.username = username
        return user
    }
}

var user1 = User()

var user2 = user1

user2.username = "Taylor"

print(user1.username)
print(user2.username)

class UserDIinit {
    let id: Int

    init(id: Int) {
        self.id = id
        print("User \(id): I'm alive!")
    }

    deinit {
        print("User \(id): I'm dead!")
    }
}

for i in 1 ... 3 {
    let user = UserDIinit(id: i)

    print("User \(user.id): I'm in control!")
}

class Animal {
    var legs: Int

    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    func speak() {
        print("Bark!")
    }
}

class Corgi: Dog {
    override func speak() {
        print("Bak!")
    }
}

class Poodle: Dog {
    override func speak() {
        print("Awoooooh!")
    }
}

class Cat: Animal {
    let isTame: Bool

    init(isTame: Bool, legs: Int) {
        self.isTame = isTame

        super.init(legs: legs)
    }

    func speak() {
        print("Meow!")
    }
}

class Persian: Cat {}
class Lion: Cat {}

let myPoodle = Poodle(legs: 4)

let lionKing = Lion(isTame: false, legs: 4)
