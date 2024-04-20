//
//  TimerView.swift
//  practiceApp
//
//  Created by mizuno on 2024/04/19.
//

import SwiftUI

struct TimerView: View {
    
    @State private var settingCountor: TimeInterval = 10.0
    @State private var timerRemaining: TimeInterval = 10.0
    @State private var timer: Timer?
    @State private var isRunning: Bool = false
    
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                ZStack {
                    Circle()
                        .stroke(lineWidth: 20)
                        .opacity(0.2)
                    Circle()
                        .stroke(lineWidth: 15)
                        .foregroundStyle(Color.white)
                        .opacity(0.2)
                    Circle()
                        .trim(from: 0, to: CGFloat(1 - (timerRemaining / settingCountor)))
                        .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                        .rotationEffect(.degrees(-90))
                        .foregroundStyle(Color.mint)
                    Text(formattedTime())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: 500)
                
                HStack {
                    Button {
                        isRunning.toggle()
                        if isRunning {
                            startTimer()
                        } else {
                            stopTimer()
                        }
                    } label: {
                        Image(systemName: isRunning ? "stop.fill" : "play.fill")
                            .foregroundStyle(isRunning ? Color.red : Color.blue)
                            .frame(width: 50, height: 50)
                            .font(.largeTitle)
                            .padding()
                    }
                    
                }
                NavigationLink("set time") {
                    SetTimeView(settingCountor: $settingCountor, timerRemaining: $timerRemaining)
                }
                .font(.title)
                
            }
            .padding(.horizontal, 30)
            
            
        }
        .navigationTitle("Timer")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func formattedTime() -> String {
        let minutes = Int(timerRemaining) / 60
        let second = Int(timerRemaining) % 60
        return String(format: "%02d:%02d", minutes, second)
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if timerRemaining > 0 {
                timerRemaining -= 0.1
            } else {
                stopTimer()
            }
        }
    }
    
    private func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timerRemaining = settingCountor
    }
}




#Preview {
    TimerView()
}

struct SetTimeView: View {
    @Binding var settingCountor: TimeInterval
    @Binding var timerRemaining: TimeInterval
    
    @State private var selectedValue = 1
    
    var body: some View {
            Picker("Select Timer", selection: $selectedValue) {
                ForEach(1..<10) { index in
                    Text("\(index * 10)")
                        .tag(index * 10)
                }
            }
            .onChange(of: selectedValue) { oldState, newValue in
                let newTimeInterval = TimeInterval(newValue)
                settingCountor = newTimeInterval
                timerRemaining = newTimeInterval
            }
            .pickerStyle(WheelPickerStyle())
        }
}
