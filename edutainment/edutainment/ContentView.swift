//
//  ContentView.swift
//  edutainment
//
//  Created by Mirna Olvera on 1/1/24.
//

import SwiftUI

struct Question {
    var answer: Int
    var question: String
    var wrongAnswers: [Int]
    var id: String
}

struct TableCard: View {
    @State private var isSelected = false
    let tableNumber: Int

    var action: () -> ()

    var body: some View {
        Button {
            isSelected.toggle()
            action()
        } label: {
            VStack {
                Text("Table \(tableNumber)")
                Text("\(tableNumber) x ?")
                    .font(.subheadline)
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundStyle(.black)
                }
            }
            .frame(width: 100, height: 100)
            .font(.system(size: 20))
            .foregroundStyle(.white)
        }
        .frame(width: 100, height: 100)
        .background(.blue)
        .cornerRadius(14)
    }
}

struct ContentView: View {
    @State private var selectedTables = [Int]()
    @State private var numberOfQuestions = 5
    @State private var gameStarted = false

    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    @State private var finshedAnswers = [Int: (Bool, Question, Int)]()
    @State private var finshedGame = false

    @State private var qs: [Question]?

    var questions: [Question] {
        if qs != nil {
            return qs ?? []
        }
        var quest = [Question]()

        let end = numberOfQuestions < 12 ? 13 : numberOfQuestions

        for table in selectedTables {
            for i in 1 ..< end {
                var wA = generateWrongAnswers(table * i)
                wA.append(table * i)

                quest.append(Question(answer: table * i, question: "What is \(table) x \(i)", wrongAnswers: wA.shuffled(), id: "id-\(table)x\(i)"))
            }
        }

        let randomQs = quest.shuffled().prefix(upTo: numberOfQuestions)

        qs = Array(randomQs)
        return Array(randomQs)
    }

    let layout = [
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80)),
    ]

    func generateWrongAnswers(_ correctAnswer: Int) -> [Int] {
        let answer = correctAnswer == 0 ? 1 : correctAnswer

        let range1 = -1 ..< answer
        let range2 = answer + 1 ..< answer * 2

        let random = range1.randomElement() ?? -1
        var secondRandom = range2.randomElement() ?? -2

        while random == secondRandom {
            secondRandom = range2.randomElement() ?? -2
        }

        return [random, secondRandom]
    }

    func addOrRemove(_ number: Int) {
        if let index = selectedTables.firstIndex(of: number) {
            selectedTables.remove(at: index)
        } else {
            selectedTables.append(number)
        }
    }

    func resetGame() {
        withAnimation {
            gameStarted = false
        }
        finshedGame = false

        finshedAnswers = [:]
        qs = nil
        selectedTables = []
    }

    func startGame() {
        if selectedTables.count >= 2 {
            withAnimation {
                gameStarted = true
            }
        } else {
            alertTitle = "Select a table"
            alertMessage = "Please select at least 2 tables"
            showAlert = true
        }
    }

    var body: some View {
        NavigationStack {
            if gameStarted == false {
                VStack(spacing: 24) {
                    HStack {
                        Text("How many questions")
                        Spacer()
                        Picker("How many questions?", selection: $numberOfQuestions) {
                            Text("5").tag(5)
                            Text("10").tag(10)
                            Text("15").tag(15)
                        }
                    }
                    .padding()

                    ScrollView {
                        LazyVGrid(columns: layout) {
                            ForEach(1 ..< 13) { number in
                                TableCard(tableNumber: number) {
                                    addOrRemove(number)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Tables")
                .toolbar {
                    Button("Start", action: startGame)
                }

            } else {
                QuestionCarouselView(numberOfQuestions: $numberOfQuestions, finshedAnswers: $finshedAnswers, finshedGame: $finshedGame, questions: questions, resetGame: {
                    resetGame()
                })
            }
        }
        .alert(alertTitle, isPresented: $showAlert) {
            Button("OK") {}
        } message: {
            Text(alertMessage)
        }
    }
}

struct QuestionCarouselView: View {
    @Binding var numberOfQuestions: Int
    @Binding var finshedAnswers: [Int: (Bool, Question, Int)]
    @Binding var finshedGame: Bool
    var questions: [Question]

    var resetGame: () -> ()

    var colors = ["#252850", "#015D52", "#293133", "#343E40", "#1F3A3D", "#6C6960", "#6C6874"]

    var correct: Int {
        var correct = 0

        finshedAnswers.forEach { _, value in
            if value.0 == true {
                correct += 1
            }
        }

        return correct
    }

    var body: some View {
        ScrollViewReader { value in
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(Array(questions.enumerated()), id: \.offset) { index, question in
                        QuestionView(question: question, color: colors.randomElement() ?? "#000000") { answer in
                            withAnimation {
                                value.scrollTo(index + 1)
                                if index + 1 == questions.count {
                                    finshedGame = true
                                    print(index, questions.count)
                                }
                            }

                            finshedAnswers[index] = (question.answer == answer, question, answer)
                        }
                    }

                    VStack {
                        Text("Answers correct \(correct) / \(numberOfQuestions)")
                            .font(.title)
                        ForEach(Array(finshedAnswers.keys), id: \.self) { key in

                            if let q = finshedAnswers[key] {
                                Text("\(q.1.question) you chose \(q.2) answer was \(q.1.answer)")
                                    .foregroundStyle(q.0 ? .green : .red)
                            } else {
                                Text("NO")
                            }
                        }

                        Button("Home") {
                            resetGame()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .scaledToFill()
                    .containerRelativeFrame(.horizontal)
                    .scrollTransition(.animated, axis: .horizontal) { content, phase in
                        content
                            .opacity(phase.isIdentity ? 1.0 : 0.8)
                            .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.black)
                    .foregroundStyle(.white)
                    .ignoresSafeArea()
                    .id(questions.count)
                }
            }
            .scrollDisabled(finshedGame)
            .ignoresSafeArea()
            .scrollTargetBehavior(.paging)
        }
        .transition(.scale)
    }
}

struct QuestionView: View {
    var question: Question
    var color: String
    var action: (Int) -> ()

    @State private var selectedAnswer = -99

    var body: some View {
        VStack {
            Spacer()
            Text(question.question)
                .font(.largeTitle)

            Spacer()

            ForEach(question.wrongAnswers, id: \.self) { an in
                Button {
                    selectedAnswer = an
                    action(an)

                } label: {
                    Text("\(an)")
                        .font(.title)
                        .padding(.horizontal)
                        .padding(.horizontal)
                        .padding()
                        .frame(minWidth: 144)
                        .background(.blue)
                        .cornerRadius(24)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(selectedAnswer == an ? .green : .black, lineWidth: 5)
                        )
                }
            }

            Spacer()
            Spacer()
        }
        .scaledToFill()
        .containerRelativeFrame(.horizontal)
        .scrollTransition(.animated, axis: .horizontal) { content, phase in
            content
                .opacity(phase.isIdentity ? 1.0 : 0.8)
                .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: color))
        .foregroundStyle(.white)
        .ignoresSafeArea()
    }
}

struct CheckBoxView: View {
    @Binding var checked: Bool

    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
            .onTapGesture {
                self.checked.toggle()
            }
    }
}

public extension Color {
    static func random(randomOpacity: Bool = false) -> Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            opacity: randomOpacity ? .random(in: 0...1) : 1
        )
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    ContentView()
}
