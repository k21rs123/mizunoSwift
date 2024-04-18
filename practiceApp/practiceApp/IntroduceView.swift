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
            HomeView()
                .tabItem {
                    Label("introduce", systemImage: "person")
                }
            
            
            StoryView()
                .tabItem {
                    Label("timer", systemImage: "clock.fill")
                }
            
            FunFactsView()
                .tabItem {
                    Label("Fun Facts", systemImage: "stopwatch.fill")
                }
            
            FavoritesView()
                .tabItem {
                    Label("todo", systemImage: "pencil.and.list.clipboard")
                }
            
            
        }
    }
}

#Preview {
    IntroduceView()
}


struct HomeView: View {
    var body: some View {
        VStack {
            Text("aa")
        }
    }
}

struct StoryView: View {
    var body: some View {
        VStack {
            Text("ss")
        }
    }
}

struct FavoritesView: View {
    var body: some View {
        VStack {
            Text("dd")
        }
    }
}

struct FunFactsView: View {
    var body: some View {
        VStack {
            Text("ff")
        }
    }
}
