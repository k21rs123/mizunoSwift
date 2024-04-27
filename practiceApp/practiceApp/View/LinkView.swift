//
//  LinkView.swift
//  practiceApp
//
//  Created by mizuno on 2024/04/19.
//

import SwiftUI

struct LinkView: View {
    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        let screenWidth = screenSize.width
        NavigationStack {
            VStack (spacing: 32, content: {
                
                NavLink(linkText: "Introduce", screenWidth: screenWidth, content: IntroduceView())
                
                NavLink(linkText: "Countor", screenWidth: screenWidth, content: CountorView())
                
                NavLink(linkText: "Timer", screenWidth: screenWidth, content: TimerView())
                
                NavLink(linkText: "StopWatch", screenWidth: screenWidth, content: StopwatchView())
                
                NavLink(linkText: "To Do", screenWidth: screenWidth, content: ToDoView())
                
                NavLink(linkText: "Camera", screenWidth: screenWidth, content: CameraAppView())
            })
        
        }
    }
}

struct NavLink<Content>: View where Content: View {
    
    let linkText: String
    let screenWidth: CGFloat
    let content: Content
    
    var body: some View {
        NavigationLink(destination: content) {
            Text(linkText)
                .frame(width: screenWidth * 0.4)
                .padding()
                .background(Color.mint, in: RoundedRectangle(cornerRadius: 16))
                .foregroundStyle(Color.white)
        }
    }
}

#Preview {
    LinkView()
}
