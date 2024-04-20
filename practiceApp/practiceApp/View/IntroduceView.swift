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
            
            StoryView()
                .tabItem {
                    Label("story", systemImage: "text.book.closed.fill")
                }
            
            HobbyView()
                .tabItem {
                    Label("likes", systemImage: "heart.fill")
                }
        }
    }
}

#Preview {
    IntroduceView()
}

struct HobbyView: View {
    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        NavigationView {
            VStack(alignment:.center) {
                Spacer()
                Text("hobby")
                    .padding()
                HStack {
                    Image(systemName: "beats.headphones")
                        .font(.largeTitle)
                        .frame(width: screenWidth * 0.1)
                    Image(systemName: "gamecontroller.fill")
                        .font(.largeTitle)
                        .frame(width: screenWidth * 0.1)
                    Image(systemName: "compass.drawing")
                        .font(.largeTitle)
                        .frame(width: screenWidth * 0.1)
                    
                }
                Text("color")
                    .padding()
                HStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: screenWidth * 0.2, height: screenHeight * 0.09)
                        .foregroundStyle(Color.mint)
                        .padding()
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: screenWidth * 0.2, height: screenHeight * 0.09)
                        .foregroundStyle(Color.green)
                        .padding()
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: screenWidth * 0.2, height: screenHeight * 0.09)
                        .foregroundStyle(Color.orange)
                        .padding()
                }
                
                Text("food")
                    .padding()
                HStack(spacing: 0) {
                    Text("🍞")
                        .font(.largeTitle)
                    Text("🍗")
                        .font(.largeTitle)
                    Text("🍚")
                        .font(.largeTitle)
                }
                
                Spacer()
                
                
            }
        }
    }
}

struct StoryView: View {
    var body: some View {
        NavigationView {
            VStack(alignment:.center) {
                Text("２００３年４月１日　生\n 水野良樹は福岡県福岡市博多区の\n原三振病院にて誕生しました。\n そのあと小学校と中学校と高校に入って卒業し、\n今は大学で自己紹介アプリを作っている最中です。\n　これからの活躍に期待！")
                    .padding()
                Spacer()
                
                
            }
            .navigationTitle("変遷")
        }
    }
}
