//
//  TimerView.swift
//  practiceApp
//
//  Created by mizuno on 2024/04/19.
//

import SwiftUI

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
        let screenHeight = screenSize.height
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
                            TextField("", text: $editMinuteText, onCommit: {
                                if let time = TimeInterval(editMinuteText) {
                                    timerRemaining = time * 60 + (timerRemaining.truncatingRemainder(dividingBy: 60))
                                    settingCountor = time * 60 + (timerRemaining.truncatingRemainder(dividingBy: 60))
                                }
                                isEditingMinute = false
                            })
                            .textFieldStyle(.roundedBorder)
                            .font(.system(size: 48))
                            .fontWeight(.bold)
                            .frame(width: screenWidth * 0.2)
                            .keyboardType(.numberPad)
                            .onAppear {
                                let minute = formattedMinute()
                                editMinuteText = minute
                            }
                        } else {
                            Text(formattedMinute())
                                .font(.system(size: 48))
                                .fontWeight(.bold)
                                .onTapGesture {
                                    isEditingMinute = true
                                }
                        }
                        Text(":")
                            .font(.system(size: 48))
                            .fontWeight(.bold)
                        if isEditingSecond {
                            TextField("", text: $editSecondText, onCommit: {
                                if let time = TimeInterval(editSecondText) {
                                    timerRemaining = time + TimeInterval(Int(timerRemaining / 60) * 60)
                                    settingCountor = time + TimeInterval(Int(timerRemaining / 60) * 60)
                                }
                                isEditingSecond = false
                            })
                            .textFieldStyle(.roundedBorder)
                            .font(.system(size: 48))
                            .fontWeight(.bold)
                            .frame(width: screenWidth * 0.2)
                            .keyboardType(.numberPad)
                            .onAppear {
                                let second = formattedSecond()
                                editSecondText = second
                            }
                        } else {
                            Text(formattedSecond())
                                .font(.system(size: 48))
                                .fontWeight(.bold)
                                .onTapGesture {
                                    isEditingSecond = true
                                }
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

#Preview {
    TimerView()
}
