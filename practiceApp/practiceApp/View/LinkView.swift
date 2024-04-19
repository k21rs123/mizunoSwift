//
//  LinkView.swift
//  practiceApp
//
//  Created by mizuno on 2024/04/19.
//

import SwiftUI

struct LinkView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Introduce") {
                    IntroduceView()
                }
                NavigationLink("Countor") {
                    CountorView()
                }
                NavigationLink("Timer") {
                    TimerView()
                }
                NavigationLink("StopWatch") {
                    StopwatchView()
                }
                NavigationLink("To Do") {
                    ToDoView()
                }
            }
        }
    }
}

#Preview {
    LinkView()
}
