import Cocoa

let platforms = ["IOS", "macOS", "TvOS", "WatchOS"]

for os in platforms {
    print("Swift works great on \(os)")
}


for i in 1...12 {
    print("5 x \(i) is \(5*i)")
}


for i in 1...5 {
    print("Counting from 1 to 5: \(i)")
}
for i in 1..<5 {
    print("Counting from 1 to 5: \(i)")
}

var countdown = 10

while countdown > 0 {
    print("\(countdown)...")
    countdown -= 1
}

print("blast off! ")
let id = Int.random(in: 1...1000)
let amount = Double.random(in: 0...1)

var roll = 0

while roll != 20 {
    roll = Int.random(in: 1...20)
    print("I rolled a \(roll)")
}

print("Critical hit")


let filenames = ["me.jpg", "work.txt", "sophie.jpg"]

for filename in filenames {
    if !filename.hasSuffix(".jpg") {
        continue
    }
    print("Found picture: \(filename)")
}


let number1 = 4
let number2 = 14

var multiple = [Int]()


for i in 1...100_000 {
    if (i.isMultiple(of: number1) && i.isMultiple(of: number2)) {
        multiple.append(i)
        
        if multiple.count == 10 {
            break
        }
    }
}
print(multiple)


for i in 1...100 {
    
    let isMultipleOf3 = i.isMultiple(of: 3)
    let isMultipleOf5 = i.isMultiple(of: 5)
    
    
    if (isMultipleOf3 && isMultipleOf5) {
        print("FizzBuzz")
        
    } else if (isMultipleOf3) {
        print("Fizz")
        
    } else if (isMultipleOf5) {
        print("Buzz")
        
    } else {
        print(i)
    }
}
