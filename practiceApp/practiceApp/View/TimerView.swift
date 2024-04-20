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
    @State private var isPause: Bool = false
    @State private var isShowAlert: Bool = false
    
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                ZStack {
                    Circle()
                        .stroke(lineWidth: 12)
                        .opacity(0.1)
                    Circle()
                        .stroke(lineWidth: 10)
                        .foregroundStyle(Color.white)
                        .opacity(0.9)
                    Circle()
                        .trim(from: 0, to: CGFloat(timerRemaining / settingCountor))
                        .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                        .rotationEffect(.degrees(-90))
                        .foregroundStyle(Color.yellow)
                    Text(formattedTime())
                        .font(.system(size: 48))
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
                            isPause = false
                        }
                    } label: {
                        Image(systemName: isRunning ? "stop.fill" : "play.fill")
                            .foregroundStyle(isRunning ? Color.red : Color.blue)
                            .frame(width: 50, height: 50)
                            .font(.largeTitle)
                            .padding()
                    }
                    
                    Button {
                        if isRunning {
                            isPause.toggle()
                            pauseTimer()
                        }
                    } label: {
                        Image(systemName: isPause ? "play.circle" : "pause.fill")
                            .foregroundStyle(isRunning ? Color.green : Color.gray)
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
            .alert("finish", isPresented: $isShowAlert) {
                Button("OK") {
                    isShowAlert.toggle()
                }
            } message: {
                Text("Time is up")
            }
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
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            if timerRemaining > 0 {
                timerRemaining -= 0.01
            } else {
                isShowAlert.toggle()
                stopTimer()
            }
        }
    }
    
    private func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timerRemaining = settingCountor
    }
    
    private func pauseTimer() {
        if isPause { timer?.invalidate() }
        else { startTimer() }
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
                ForEach(1..<19) { index in
                    Text("\(index * 10)").tag(index * 10)
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
