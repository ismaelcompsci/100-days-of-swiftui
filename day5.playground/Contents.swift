import Cocoa

let score = 85

if score > 80 {
    print("Great Job")
}

let speed = 88

let percentage = 85
let age = 18

if speed >= 88 {
    print("Where we're going we don't need roads")
}

if percentage < 85 {
    print("Sorry, you failed the test")
}

if age >= 18 {
    print("You're eligible to vote.")
}

var numbers = [1, 2, 3]
numbers.append(4)

if numbers.count > 3 {
    numbers.remove(at: 0)
}

print(numbers)

let country = "Canada"

if country == "Australia" {
    print("G'day")
}

var username = "taylorswift"

if username.isEmpty {
    username = "Anon"
}

enum Weather {
    case sun, rain, wind, snow, unknown
}

let forecast = Weather.sun

switch forecast {
case .sun:
    print("Sunny")
case .rain:
    print("Rain")
case .wind:
    print("Windy")
case .snow:
    print("Snowy")
case .unknown:
    print("IDK")
}

// ternary

let age1 = 18


let canVote = age >= 18 ? "Yes": "No"
