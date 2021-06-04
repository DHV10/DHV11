//
//  ContentView.swift
//  ls5
//
//  Created by DHV on 11/05/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var symbols = ["apple", "cherry", "star"]
    @State private var number = Array(repeating: 0, count: 9)
    @State private var backgrounds = Array(repeating: Color.white, count: 9)
    @State private var credits = 1000
    @State private var win = false
    private var betAmount = 5
    
    var body: some View {
        
        ZStack {
            
            //background
            Rectangle().foregroundColor(Color(red: 200/255, green: 143/255, blue: 32/255)).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            Rectangle().foregroundColor(Color(red: 228/255, green: 195/255, blue: 76/255)).rotationEffect(Angle(degrees: 45)).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                Spacer()
                //title
                HStack {
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                    
                    Text("SwiftUI Slots").foregroundColor(.white)
                    
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                }.scaleEffect(2.5)
                Spacer()
                //credits counter
                Text("Credits: " + String(credits) ).foregroundColor(.black)
                    .padding(.all,10)
                    .background(win ? Color.green.opacity(0.5) : Color.white.opacity(0.5) )
                    .animation(.none)
                    .cornerRadius(20)
                    .scaleEffect(win ? 1.2 : 1)
                    .animation(.spring(response: 0.7, dampingFraction:  0.5))
                Spacer()
                
                //Card
                VStack{
                    HStack {
                        Spacer()
                        
                        
                        CardView(symbol: $symbols[number[0]], background: $backgrounds[0])
                        
                        CardView(symbol: $symbols[number[1]], background: $backgrounds[1])
                        
                        CardView(symbol: $symbols[number[2]], background: $backgrounds[2])
                        
                        
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        
                        
                        CardView(symbol: $symbols[number[3]], background: $backgrounds[3])
                        
                        CardView(symbol: $symbols[number[4]], background: $backgrounds[4])
                        
                        CardView(symbol: $symbols[number[5]], background: $backgrounds[5])
                        
                        
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        
                        
                        CardView(symbol: $symbols[number[6]], background: $backgrounds[6])
                        
                        CardView(symbol: $symbols[number[7]], background: $backgrounds[7])
                        
                        CardView(symbol: $symbols[number[8]], background: $backgrounds[8])
                        
                        
                        Spacer()
                    }
                }
                
                
                //Spin
                Spacer()
                
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            
                            self.processResult()
                            
                        }, label: {
                            Text("Spin")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.all, 10)
                                .padding(.horizontal, 45.0)
                                .background(Color.pink)
                                .cornerRadius(20)
                        })
                        Text("\(betAmount) credits")
                    }
                    Spacer()
                    VStack {
                        Button(action: {
                            
                            self.processResult(true)
                            
                        }, label: {
                            Text("Max Spin")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.all, 10)
                                .padding(.horizontal, 30.0)
                                .background(Color.pink)
                                .cornerRadius(20)
                        })
                        Text("\(betAmount * 5) credits")
                    }
                    Spacer()
                }
                
                
                Spacer()
            }
            
        }
        .animation(.default)
        
    }
    
    func processResult(_ isMax: Bool = false){
        //reset background
        
        self.backgrounds = self.backgrounds.map({ _ in
            Color.white
        })
        
        //changed image
        if isMax {
            //spin all card
            self.number = self.number.map({ _ in
                Int.random(in: 0...self.symbols.count - 1)
            })
        }else {
            //spin middle row
            self.number[3] =  Int.random(in: 0...self.symbols.count - 1)
            self.number[4] =  Int.random(in: 0...self.symbols.count - 1)
            self.number[5] =  Int.random(in: 0...self.symbols.count - 1)
            
        }
        
        self.processWin(isMax)
        
    }
    
    func processWin( _ isMax: Bool = false) {
        var matches = 0
        //
        if !isMax {
            //check win for single spin
            if isMatch(3, 4, 5){
                matches += 1
            }
            
        }
        else {
            // check for max spin
            if isMatch(3, 4, 5){
                matches += 1
            }
            
            if isMatch(0, 1, 2){
                matches += 1
            }
            if isMatch(6, 7, 8){
                matches += 1
            }
            if isMatch(0, 4, 8){
                matches += 1
            }
            if isMatch(2, 4, 6){
                matches += 1
            }
            if isMatch(0, 3, 6){
                matches += 1
            }
            if isMatch(2, 5, 8){
                matches += 1
            }
            if isMatch(1, 4, 7){
                matches += 1
            }
            
        }
        self.win = false
        if matches > 0 {
            // at least 1 win
            self.win = true
            self.credits += matches * betAmount * 2
        }
        else if !isMax {
            // 0 win single spin
            
            self.credits -= betAmount
        }
        else {
            // 0 win max spin
            self.credits -= betAmount * 5
        }
    }
    func isMatch(_ index1: Int, _ index2: Int, _ index3: Int) -> Bool {
        
        if self.number[index1] == self.number[index2] && self.number[index2] == self.number[index3] {
            
            self.backgrounds[index1] = Color.green
            self.backgrounds[index2] = Color.green
            self.backgrounds[index3] = Color.green
            
            return true	
        }
        
        return  false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
