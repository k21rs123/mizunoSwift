//
//  TimerView.swift
//  practiceApp
//
//  Created by mizuno on 2024/04/19.
//

import SwiftUI
import Combine

struct TimerView: View {
    
    @State private var settingCountor: TimeInterval = 0.0
    @State private var timerRemaining: TimeInterval = 0.0
    @State private var timer: Timer?
    @State private var isRunning: Bool = false
    @State private var isPause: Bool = false
    @State private var isShowAlert: Bool = false
    
    @State private var isEditingMinute: Bool = false
    @State private var isEditingSecond: Bool = false
    @State private var editMinuteText: String = ""
    @State private var editSecondText: String = ""
    
    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        let screenWidth = screenSize.width
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
                    HStack {
                        if isEditingMinute {
                            SettingTextField(editText: $editMinuteText, isEditing: $isEditingMinute, timerRemaining: $timerRemaining, settingCountor: $settingCountor, formatTime: formattedMinute(), screenWidth: screenWidth,isSecond: false)
                        } else {
                            TimerText(isEditing: $isEditingMinute, time: formattedMinute())
                            
                        }
                        Text(":")
                            .font(.system(size: 48))
                            .fontWeight(.bold)
                        if isEditingSecond {
                            SettingTextField(editText: $editSecondText, isEditing: $isEditingSecond, timerRemaining: $timerRemaining, settingCountor: $settingCountor, formatTime: formattedSecond(), screenWidth: screenWidth,isSecond: true)
                        } else {
                            TimerText(isEditing: $isEditingSecond, time: formattedSecond())
                        }
                    }
                    
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
                            .foregroundStyle(timerRemaining < 1 && !isRunning ? Color.gray :(isRunning ? Color.red : Color.blue))
                            .font(.largeTitle)
                            .padding(32)
                    }
                    .disabled(timerRemaining < 1 && !isRunning)
                    
                    Button {
                        if isRunning {
                            isPause.toggle()
                            pauseTimer()
                        }
                    } label: {
                        Image(systemName: isPause ? "play.circle" : "pause.fill")
                            .foregroundStyle(isRunning ? Color.green : Color.gray)
                            .font(.largeTitle)
                            .padding(32)
                    }
                }
                
                Button {
                    timerRemaining = 0
                    settingCountor = 0
                } label: {
                    Text("Reset")
                        .font(.largeTitle)
                }
            }
            .padding(.horizontal, 30)
            .alert("finish", isPresented: $isShowAlert) {
                Button("OK") { isShowAlert.toggle() }
            } message: {
                Text("Time is up")
            }
        }
        .navigationTitle("Timer")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func formattedMinute() -> String {
        let minutes = Int(timerRemaining) / 60
        return String(format: "%02d", minutes)
        
    }
    private func formattedSecond() -> String {
        let second = Int(timerRemaining) % 60
        return String(format: "%02d", second)
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
struct TimerText: View {
    @Binding var isEditing: Bool
    let time: String
    var body: some View {
        Text(time).font(.system(size: 48)).fontWeight(.bold).onTapGesture { isEditing = true }
    }
}

struct SettingTextField: View {
    @Binding var editText: String
    @Binding var isEditing: Bool
    @Binding var timerRemaining: TimeInterval
    @Binding var settingCountor: TimeInterval
    let formatTime: String
    let screenWidth: CGFloat
    let isSecond: Bool
    var body: some View {
        TextField("", text: $editText, onCommit: {
            if var time = TimeInterval(editText) {
                if isSecond {
                    if time > 10800 { time = 10800 }
                    timerRemaining = time + TimeInterval(Int(timerRemaining))
                } else {
                    if time > 180 { time = 180 }
                    timerRemaining = time * 60 + (timerRemaining.truncatingRemainder(dividingBy: 60))
                }
                settingCountor = timerRemaining
            }
            isEditing = false
        })
        .textFieldStyle(.roundedBorder)
        .font(.system(size: 48))
        .fontWeight(.bold)
        .frame(width: screenWidth * 0.2)
        .keyboardType(.numberPad)
        .onAppear { editText = formatTime }
    }
}

#Preview {
    TimerView()
}
