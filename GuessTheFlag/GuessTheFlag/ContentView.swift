//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mirna Olvera on 12/22/23.
//

import SwiftUI

struct FlagImage: View {
    let flagName: String
    var body: some View {
        Image(flagName)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct FlagButton: View {
    var number: Int
    var image: String
    var correctAnswer: Int
    @Binding var showAnimation: Bool
    @Binding var selectedFlag: Int

    var action: () -> ()

    @State private var animationAmount = 0.0

    var body: some View {
        Button {
            withAnimation {
                animationAmount += 360
            }
            action()
        } label: {
            FlagImage(flagName: image)
        }
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
        .opacity(showAnimation && correctAnswer != number ? 0.25 : 1)
        .scaleEffect(showAnimation && selectedFlag != number ? 0.4 : 1)
        .animation(.default, value: animationAmount)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()

    @State private var correctAnswer = Int.random(in: 0 ... 2)
    @State private var userScore = 0

    @State private var showingScore = false
    @State private var scoreTitle = ""

    @State private var showingReset = false
    @State private var questionsAsked = 0

    @State private var animationAmount = 0.0
    @State private var selectedFlag = -1

    @State private var showAnimation = false

    var body: some View {
        ZStack {
            RadialGradient(stops: [.init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3), .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()

            VStack {
                Spacer()

                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(0 ..< 3) { number in
                        FlagButton(number: number, image: countries[number], correctAnswer: correctAnswer, showAnimation: $showAnimation, selectedFlag: $selectedFlag) {
                            flagTapped(number)
                            selectedFlag = number
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))

                Spacer()
                Spacer()

                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(userScore)")
        }

        .alert("Reset Game", isPresented: $showingReset) {
            Button("Reset", action: resetGame)
        }
    }

    func flagTapped(_ number: Int) {
        showAnimation = true
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
        } else {
            scoreTitle = "Wrong! thats the flag of \(countries[number])"
        }

        showingScore = true
    }

    func askQuestion() {
        if questionsAsked >= 8 {
            showingReset = true
        }

        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
        showAnimation = false
        questionsAsked += 1
    }

    func resetGame() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
        questionsAsked = 0
        userScore = 0
        showAnimation = false
    }
}

#Preview {
    ContentView()
}
