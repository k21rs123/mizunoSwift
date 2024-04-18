//
//  ContentView.swift
//  practiceApp
//
//  Created by mizuno on 2024/04/16.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingView: Bool = false
    
    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        //        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        
        
        VStack {
            
            if isShowingView {
                
                IntroduceView()
                
            } else {
                
                Text("水野")
                    .font(.largeTitle)
                    .padding()
                Text("良基")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding()
                Button {
                    isShowingView.toggle()
                } label: {
                    Text("Click Here")
                        .padding()
                        .background(Color.mint, in: RoundedRectangle(cornerRadius: 8))
                        .font(.title2)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                }
            }
            
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    ContentView()
}

