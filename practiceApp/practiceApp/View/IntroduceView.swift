//
//  IntroduceView.swift
//  practiceApp
//
//  Created by mizuno on 2024/04/18.
//

import SwiftUI

struct IntroduceView: View {
    var body: some View {
        TabView{
            MyInfoView()
                .tabItem {
                    Label("introduce", systemImage: "person")
                }
            
            
            TimerView()
                .tabItem {
                    Label("timer", systemImage: "clock.fill")
                }
            
            StopwatchView()
                .tabItem {
                    Label("stopwatch", systemImage: "stopwatch.fill")
                }
            
            ToDoView()
                .tabItem {
                    Label("todo", systemImage: "pencil.and.list.clipboard")
                }
            
            
        }
    }
}

#Preview {
    IntroduceView()
}








