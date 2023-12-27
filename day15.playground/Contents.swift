import Cocoa

// closures
let team = ["Gloria", "Suzanne", "Tiffany", "Tash"]
let onlyT = team.filter { (name: String) -> Bool in
    name.hasPrefix("T")
}

print(onlyT)

struct Employee {
    let name: String
    var vacationAllowed = 14
    var vacationTaken = 0
    // computed value
    var vacationRemaining: Int {
        get {
            vacationAllowed - vacationTaken
        }

        set {
            vacationAllowed = vacationTaken + newValue
        }
    }
}

struct Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

extension Collection {
    var isNotEmpty: Bool {
        isEmpty == false
    }
}
