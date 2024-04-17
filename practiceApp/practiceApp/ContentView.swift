//
//  ContentView.swift
//  practiceApp
//
//  Created by mizuno on 2024/04/16.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        //        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        VStack {
            Rectangle()
                .frame(width: .infinity , height: screenHeight * 0.1)
                .foregroundColor(Color(red: 40/255, green: 120/255, blue: 200/255))
            
            NavigationLink(destination: IntroduceView()) {
                CustomButton(screenHeight: screenHeight, text: "Introduce", backgroundColor: Color(red: 50/255, green: 160/255, blue: 200/255))
            }
            NavigationLink("Introduce") {
                IntroduceView()
            }
            
            CustomNavigationView(screenHeight: screenHeight, text: "Introduce", backgroundColor: Color(red: 50/255, green: 160/255, blue: 200/255), destination: { IntroduceView() })
            
            
            
            CustomButton(screenHeight: screenHeight, text: "Countor", backgroundColor: Color(red: 60/255, green: 170/255, blue: 200/255))
            CustomButton(screenHeight: screenHeight, text: "Timer", backgroundColor: Color(red: 70/255, green: 180/255, blue: 200/255))
            CustomButton(screenHeight: screenHeight, text: "Calculator", backgroundColor: Color(red: 80/255, green: 190/255, blue: 200/255))
            CustomButton(screenHeight: screenHeight, text: "StopWatch", backgroundColor: Color(red: 90/255, green: 200/255, blue: 200/255))
            CustomButton(screenHeight: screenHeight, text: "To Do", backgroundColor: Color(red: 100/255, green: 210/255, blue: 200/255))
            
            
        }
        .ignoresSafeArea(.all)
    }
}

struct CustomNavigationView: View {
    let screenHeight: CGFloat
    let text: String
    let backgroundColor: Color
    let destination: destination
    
    var body: some View {
        NavigationLink(text) {
            destination() // クロージャーを呼び出してビューを取得
        }
        .frame(maxWidth: .infinity)
        .frame(height: screenHeight * 0.15)
        .background(backgroundColor)
        .font(.system(size: 48))
        .bold()
        .foregroundColor(.white)
    }
}


struct CustomButton: View {
    let screenHeight: CGFloat
    let text: String
    let backgroundColor: Color
    
    var body: some View {
        Button(action: {}) {
            Text(text)
                .frame(maxWidth: .infinity)
                .frame(height: screenHeight * 0.15)
                .background(backgroundColor)
                .font(.system(size: 48))
                .bold()
                .foregroundColor(.white)
        }
    }
}

#Preview {
    ContentView()
}
