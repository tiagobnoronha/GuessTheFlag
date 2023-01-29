//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Tiago Baptista Noronha on 17/01/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    
    @State private var showingFinish = false
    
    @State private var score = 0;
    
    @State private var turn = 1;
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    private var scoreFormatted : String { String(format: "%03d", score)}
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red:0.1, green:0.2, blue:0.45), location: 0.3),
                .init(color:Color(red:0.76, green:0.15, blue:0.25), location:0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack (spacing:30){
                    
                    
                    VStack(spacing: 15){
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3){ number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(scoreFormatted)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreMessage)
        }
        
        .alert("Finish", isPresented: $showingFinish){
            Button("Restart", action: restartGame)
        } message:{
            Text("Your Final Score is \(scoreFormatted)!!!")
        }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreMessage = "Perfect! You are correct!"
            score += 100
        } else {
            scoreTitle = "Wrong"
            scoreMessage = "Wrong! That's the flag of \(countries[number])"
            score -= 50
            if score < 0 {
                score = 0
            }
        }
        
        showingScore = true
    }
    
    func askQuestion(){
        if turn == 8 {
            showingFinish = true;
        }else{
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            turn+=1
        }
    }
    
    func restartGame(){
        turn = 1;
        score = 0;
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
