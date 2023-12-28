//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Mirna Olvera on 12/27/23.
//

import SwiftUI

struct ContentView: View {
    let moves = ["Rock 🪨", "Paper 📄", "Scissors ✂️"]

    @State private var currentChoice = Int.random(in: 0 ..< 3)
    @State private var shouldWin = Bool.random()

    @State private var score = 0
    @State private var gamesPlayed = 0
    @State private var isGameFinished = false

    func restartGame() {
        score = 0
        gamesPlayed = 0
        isGameFinished = false
    }

    func newRound() {
        if gamesPlayed >= 10 {
            isGameFinished = true
        }

        gamesPlayed += 1
        currentChoice = Int.random(in: 0 ..< 3)
        shouldWin = Bool.random()
    }

    func handlePlay(_ moveIndex: Int) {
        switch currentChoice {
        case 0:
            // rock
            if shouldWin {
                if moveIndex == 1 {
                    score += 1
                }
            } else {
                if moveIndex == 2 {
                    score += 1
                }
            }
        case 1:
            // paper
            if shouldWin {
                if moveIndex == 2 {
                    score += 1
                }
            } else {
                if moveIndex == 0 {
                    score += 1
                }
            }
        case 2:
            // scissors
            if shouldWin {
                if moveIndex == 0 {
                    score += 1
                }
            } else {
                if moveIndex == 1 {
                    score += 1
                }
            }
        default:
            break
        }

        newRound()
    }

    var body: some View {
        VStack {
            if isGameFinished == false {
                Text("Your score is: \(score)")
                    .font(.largeTitle)
                Spacer()
                Text("Opponent's move: \(moves[currentChoice])")
                    .font(.title)

                HStack {
                    Text("This round you should")
                    Text("\(shouldWin ? "win" : "lose")")
                        .underline()
                }
                .font(.title2)

                HStack {
                    ForEach(moves.indices, id: \.self) { index in
                        Button {
                            handlePlay(index)
                        } label: {
                            Text(moves[index])
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                Spacer()
            } else {
                Text("The game is finsihed you scored \(score)")

                Button {
                    restartGame()
                } label: {
                    Text("Play again!")

                }.buttonStyle(.bordered)
            }
        }
    }
}

#Preview {
    ContentView()
}
