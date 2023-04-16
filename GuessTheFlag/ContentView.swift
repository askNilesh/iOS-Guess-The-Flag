//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Nilesh Rathod on 15/04/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var showingFinalScore = false
    @State private var  scroreTitle = ""
    @State private var  message = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var scoreCount  = 0
    @State private var questionCount  = 1
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red :0.1, green:0.2, blue :0.45), location:0.3),
                .init(color: Color(red :0.76, green:0.15, blue :0.26), location:0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            
            VStack {
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.secondary)
                VStack (spacing: 15){
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                    
                        .font(.largeTitle.weight(.semibold))
                    ForEach(0..<3){ number in
                        Button{
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(scoreCount)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
        }.alert(scroreTitle, isPresented: $showingScore){
            Button("Continue", action : askQuestion)
        } message : {
            Text(" \(message)")
        }
        .alert("Game over", isPresented: $showingFinalScore){
            Button("Reset"){
                questionCount = 0
                scoreCount = 0
                askQuestion()
            }
        } message : {
            Text("Your score is \(scoreCount)")
        }
        
        
    }
    
    func flagTapped(_  number : Int){
        if(number == correctAnswer){
            scroreTitle = "Correct"
            scoreCount += 1
            message = "Correct, this is the flag of \(correctAnswer)"
        }else {
            scroreTitle = "Wrong"
            message = "Wrong, this is the flag of \(countries[number])"
        }
        if(questionCount == 8){
            showingFinalScore = true
        }else {
            showingScore = true
        }
        
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCount += 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
