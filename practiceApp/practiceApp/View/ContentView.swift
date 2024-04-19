//
//  ContentView.swift
//  practiceApp
//
//  Created by mizuno on 2024/04/16.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingView: Bool = false
    let frontGradientView: LinearGradient = LinearGradient(gradient: Gradient(colors: [.mint, .cyan]), startPoint: .topLeading, endPoint: .bottomTrailing)
    let backGradientView: LinearGradient = LinearGradient(gradient: Gradient(colors: [.cyan, .green]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    
    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        //        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        
        
        VStack {
            
            if isShowingView {
                
                IntroduceView()
                
            } else {
                Text("自己紹介アプリを作りSwiftUIの基本的な使い方を知ろうアプリ。")
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(8)
                    .shadow(radius: 8)
                    .padding()
                    
                ZStack {
                    Circle()
                        .frame(width: 200, height: 200)
                        .offset(x: 20, y: 8)
                        .foregroundStyle(backGradientView)
                        .foregroundStyle(.ultraThickMaterial)
                        .shadow(color: .init(white: 0.4, opacity: 0.4), radius: 5, x: 0, y: 0)
                    Circle()
                        .frame(width: 200, height: 200)
                        .offset(x: -20, y: -8)
                        .foregroundStyle(frontGradientView)
                        .foregroundStyle(.ultraThickMaterial)
                        .shadow(color: .init(white: 0.4, opacity: 0.4), radius: 5, x: 0, y: 0)
                    Button(action: {
                        print("button tapped")
                        isShowingView.toggle()
                    }){
                        Text("Osite!11!!!!!!")
                            .font(.system(size: 25, weight: .semibold, design: .default))
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                // ぼかし効果
                                    .foregroundStyle(.ultraThinMaterial)
                                // ドロップシャドウで立体感を表現
                                    .shadow(color: .init(white: 0.4, opacity: 0.4), radius: 5, x: 0, y: 0)
                            )
                            .overlay(
                                // strokeでガラスの縁を表現
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.init(white: 1, opacity: 0.5), lineWidth: 1)
                            )
                    }
                }
            }
            
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    ContentView()
}

