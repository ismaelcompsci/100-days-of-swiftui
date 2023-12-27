import Cocoa

// Arrays
var beatles = ["john", "paul", "george", "ringo"]
var numbers = [3, 8, 16, 23, 52]

let number = numbers[3]

numbers.append(4)

var scores = [Int]()
scores.append(180)
scores.append(80)
scores.append(85)
print(scores[1])

var albums = [String]()
albums.append("Fearless")
albums.append("Red")

print(albums.count)
albums.remove(at: 1)

let bondMoives = ["Casino", "Spectre", "No Time to Die"]
print(bondMoives.contains("Frozen"))

let cities = ["London", "Tokyo", "Rome"]
print(cities.sorted())

print(cities.reversed())

// Dictionaries
let employee2 = [
    "name": "Taylor Swift",
    "job": "Nashville",
    "location": "Singer",
]
print(employee2["name", default: "Unknown"])
print(employee2["job", default: "Unknown"])
print(employee2["location", default: "Unkn own"])

let hadGraduated = [
    "Eric": false,
    "Maeve": false,
]

let olympics = [
    2012: "London",
    2016: "Rio de Janeiro",
]

print(olympics[2012, default: "Unknown"])

var heights = [String: Int]()
heights["Yao Ming"] = 229
heights["Shaquille O'Neal"] = 216

// Sets
let actors = Set([
    "Denzel Washington",
    "Tom Cruise",
    "Nicolas Cage",
])

var animals = Set<String>()
animals.insert("Dog")
animals.insert("Cat")
animals.insert("Bird")


// enums
enum Weekday {
    case monday
    case tuesday
    case wendesday
    case thursday
    case friday
}

enum Months {
    case january, febuary
}

var day = Weekday.monday
day = .thursday
print(day)
