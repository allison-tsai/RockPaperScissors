//
//  ContentView.swift
//  WinOrLoseRockPaperScissors
//
//  Created by Allison Tsai on 5/5/23.
//

import SwiftUI

struct ContentView: View {
    let possibleMoves = ["Rock", "Paper", "Scissors"]
    let winningMoves = ["Paper", "Scissors", "Rock"]
    let losingMoves = ["Scissors", "Rock", "Paper"]
    
    // game set-up
    @State private var appCurrentChoice = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var playerScore = 0
    
    let maxQuestions = 10
    @State private var numQuestions = 0
    @State private var gameOver = false
    let gameOverMsg = "Good Game!"
    
    // a player move is made
    @State var playerChoice = "player choice here"
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Score: \(playerScore) out of \(numQuestions)")

            Spacer()
            
            VStack {
                Text("Given:")
                Text("\(possibleMoves[appCurrentChoice])\n")
                    .font(.title)
                if shouldWin {
                    Text("Pick the winning move:")
                        .italic()
                } else {
                    Text("Pick the losing move:")
                        .italic()
                }
                
                VStack {
                    ForEach(0..<3) { number in
                        Button {
                            moveMade(number)            // e.g. player taps Rock, this'll call moveMade(0)
                        } label: {
                            Text(possibleMoves[number])
                        }
                        .buttonStyle(BorderedButtonStyle())
                        .tint(.purple)
                        .clipShape(Capsule())
                    }
                }
            }

            Spacer()
            Spacer()
        }
        .alert(gameOverMsg, isPresented: $gameOver) {
            Button("Play again", action: reset)
        } message: {
            Text("Final score: \(playerScore) out of \(numQuestions)")
        }
    }
    
    func moveMade(_ number: Int) {
        numQuestions += 1
        
        playerChoice = possibleMoves[number]
        if shouldWin {
            playerChoice == winningMoves[appCurrentChoice] ? scorePoint() : losePoint()
        } else {
            playerChoice == losingMoves[appCurrentChoice] ? scorePoint() : losePoint()
        }
        
        askQuestion()
    }
    
    func scorePoint() {
        playerScore += 1
    }
    
    func losePoint() {
        playerScore -= 1
    }
    
    func askQuestion() {
        if numQuestions >= maxQuestions {
            gameOver = true
        } else {
            appCurrentChoice = Int.random(in: 0..<3)
            shouldWin.toggle()
        }
    }
    
    func reset() {
        gameOver = false
        numQuestions = 0
        playerScore = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
