//
//  MyInfoView.swift
//  practiceApp
//
//  Created by mizuno on 2024/04/19.
//

import SwiftUI

struct MyInfoView: View {
    var body: some View {
        
        let screenSize = UIScreen.main.bounds.size
        let screenWidth = screenSize.width
//        let screenHeight = screenSize.height
        
        VStack {
            HStack(spacing: 0, content: {
                
                Image("M")
                    .resizable()
                    .frame(width: screenWidth * 0.2,height: screenWidth * 0.2)
                    .clipShape(Circle())
                    .shadow(radius: 4)
                    .padding([.horizontal],screenWidth * 0.1)
                    
                VStack (alignment: .leading, spacing: 0, content: {
        
                    Text("水野良基")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    Text("大学４年生")
                        .font(.headline)
                        .foregroundStyle(Color.secondary)
                        .multilineTextAlignment(.leading)
                })
                Spacer()
                
            })
            
            NavigationView {
                List {
                    Text("出身：福岡県　福岡市　博多区")
                        .padding()
                        .font(.title3)
                    Text("好きな天気：晴れ")
                        .padding()
                        .font(.title3)
                    Text("好きな季節：秋")
                        .padding()
                        .font(.title3)
                    Text("好きなゲーム：原神")
                        .padding()
                        .font(.title3)
                    Text("好きな本：Kotlin")
                        .padding()
                        .font(.title3)
                    Text("ひとこと：よろしくお願いします")
                        .padding()
                        .font(.title3)
                }
                .navigationTitle("自己紹介")
            }
            
            
            Spacer()
        }
    }
}


#Preview {
    MyInfoView()
}
