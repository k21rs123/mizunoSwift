//
//  CountorView.swift
//  practiceApp
//
//  Created by mizuno on 2024/04/19.
//

import SwiftUI

struct CountorView: View {
    @State var count: Int = 0
    @State var textColor: Color = .black
    
    var body: some View {
        VStack (spacing: 16) {
            
            Text("\(count)")
                .foregroundStyle(textColor)
                .font(.title)
            
            Button(action: {updateCount(1)})
            {Text("add")}
            
            Button(action: {updateCount(-1)})
            {Text("sub").foregroundStyle(Color.red)}
            
            Button(action: {resetCount()})
            {Text("reset").foregroundStyle(Color.black)}
            
        }
        .padding()
        .navigationTitle("Countor")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    private func updateCount(_ value: Int) {
        count += value
        textColor = updateTextColor(count: count)
    }
    
    private func resetCount() {
        count = 0
        textColor = .black
    }
}

private func updateTextColor(count: Int) -> Color {
    var color:Color = .black
    
    if count == 0 { color = Color.black }
    else if count > 9 { color = Color.blue }
    else if count < 0 { color = Color.red }
    
    return  color
}

#Preview {
    CountorView()
}
