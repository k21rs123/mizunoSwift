//
//  StopwatchView.swift
//  practiceApp
//
//  Created by mizuno on 2024/04/19.
//

import SwiftUI

struct StopwatchView: View {
    @State private var timerRemaining: TimeInterval = 0.00
    @State private var timer: Timer?
    
    @State private var isRunning: Bool = false
    @State private var isStop: Bool = false
    @State private var isActive: Bool = false
    
    @State private var firstLap: String = ""
    @State private var secondLap: String = ""
    @State private var thirdLap: String = ""
    
    var body: some View {
        let size = UIScreen.main.bounds.size
        let screenHeight = size.height
        let screenWidth = size.width
        
        VStack {
            Spacer()
            Text(formatTime())
                .font(.system(size: screenHeight * 0.1))
                .frame(maxWidth: screenWidth * 0.9)
                .frame(minWidth: screenWidth * 0.9)
            ScrollView {
                Text(firstLap)
                    .foregroundStyle(Color.black)
                Text(secondLap)
                    .foregroundStyle(Color.gray)
                Text(thirdLap)
                    .foregroundStyle(Color.gray)
            }
            .frame(width: screenWidth * 0.8, height: screenHeight * 0.1)
            .padding()
            .background(Color(white: 0.95), in: RoundedRectangle(cornerRadius: 6))
            HStack {
                Button(action: {
                    if isStop {
                        isRunning = false
                        isStop = false
                        isActive = false
                        resetTimer()
                    } else {
                        lapTimer()
                    }
                }) {
                    Text(isStop ? "Reset" : "Lap")
                        .foregroundStyle(isActive ? Color.blue : Color.gray)
                }
                .disabled(!isActive)
                Button(action: {
                    isRunning.toggle()
                    
                    if isRunning {
                        isStop = false
                        isActive = true
                        startTimer()
                    } else {
                        stopTimer()
                    }
                    
                }) {
                    Text(isRunning ? "Stop" : "Start")
                        .foregroundStyle(isRunning ? Color.red : Color.green)
                }
            }
            Spacer()
        }
        .padding()
        .navigationTitle("StopWatch")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { _ in
            timerRemaining += 0.01
        })
    }
    
    private func stopTimer() {
        timer?.invalidate()
        isStop = true
        
    }
    
    private func resetTimer() {
        timerRemaining = 0
        firstLap = ""
        secondLap = ""
        thirdLap = ""
    }
    
    private func lapTimer() {
        thirdLap = secondLap
        secondLap = firstLap
        firstLap = "LAP:\(formatTime())"
    }
    
    private func formatTime() -> String {
        let minutes = Int(timerRemaining) / 60
        let second = Int(timerRemaining) % 60
        let decimal = Int((timerRemaining - floor(timerRemaining)) * 100)
        return String(format: "%02d:%02d.%02d", minutes, second, decimal)
    }
}

#Preview {
    StopwatchView()
}
