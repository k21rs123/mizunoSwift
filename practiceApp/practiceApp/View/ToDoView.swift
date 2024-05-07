//
//  ToDoView.swift
//  practiceApp
//
//  Created by mizuno on 2024/04/19.
//

import SwiftUI
//import SwiftData


struct ToDoItem: Codable {
    var isChecked: Bool
    var task: String
}

struct ToDoView: View {
    
    @State private var newTask: String = ""
    
    @State private var todoLists: [ToDoItem] = ((UserDefaults.standard.data(forKey: "key"))
        .flatMap { try? JSONDecoder().decode([ToDoItem].self, from: $0) }) ?? []
    
    @State private var toggleAllCheck = false
    
    
    var body: some View {
        
        let size = UIScreen.main.bounds.size
        let screenWidth = size.width
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Button(action: {
                    todoLists = deleteToDoTask(todoLists: todoLists)
                    toggleAllCheck.toggle()
                }) {
                    Image(systemName: "trash")
                        .foregroundStyle(todoLists.contains(where: {$0.isChecked}) ? Color.blue : Color.gray)
                        .padding()
                }
                .disabled(!todoLists.contains(where: {$0.isChecked}))
            }
            
            HStack {
                TextField("タスクを入力してください", text: $newTask)
                    .textFieldStyle(.roundedBorder)
                    .padding(EdgeInsets(
                        top: 10,
                        leading: 20,
                        bottom: 10,
                        trailing: 15
                    ))
                Button("追加", action: {
                    todoLists.append(
                        ToDoItem(isChecked: false, task: newTask)
                    )
                    saveToDoTask(todoLists: todoLists)
                    
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                    newTask = ""
                })
            }
            .padding()
            
            HStack {
                Button(action: {
                    toggleAllCheck.toggle()
                    for index in todoLists.indices {
                        todoLists[index].isChecked = toggleAllCheck
                    }
                    
                }, label: {
                    Image(systemName: toggleAllCheck ? "checkmark.square" : "square")
                        .foregroundStyle(Color.red)
                    Text("All")
                        .foregroundStyle(Color.gray)
                })
                .font(.system(size: 20))
                .padding(.leading , screenWidth * 0.15)
                .padding(.bottom, 8)
                
                Spacer()
                
            }
            
            List {
                ForEach(todoLists.indices, id: \.self) { index in
                    HStack {
                        Button(action: {
                            todoLists[index].isChecked.toggle()
                            toggleAllCheck = false
                        }, label: {
                            Image(systemName:
                                    todoLists[index].isChecked ? "checkmark.square" : "square"
                            )
                            .imageScale(.large)
                            .foregroundStyle(.pink)
                        })
                        Text(todoLists[index].task)
                    }
                    .padding(.top, 1)
                    .padding(.leading, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        
        .navigationTitle("ToDo List")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ToDoView()
}

struct ExtractedView: View {
    var body: some View {
        VStack {
            Text("aaa")
        }
    }
}
