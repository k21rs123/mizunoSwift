//
//  ToDoView.swift
//  practiceApp
//
//  Created by mizuno on 2024/04/19.
//

import SwiftUI
import SwiftData


struct ToDoItem: Codable {
    var isChecked: Bool
    var task: String
}

struct ToDoView: View {
    
    @State private var newTask: String = ""
    
    @State private var todoLists: [ToDoItem] = ((UserDefaults.standard.data(forKey: "key"))
        .flatMap { try? JSONDecoder().decode([ToDoItem].self, from: $0) }) ?? []
    
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    todoLists = deleteToDoTask(todoLists: todoLists)
                }) {
                    Text("完了済みを削除")
                }
                .padding() 
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
                .padding(.trailing, 20)
            }
            List {
                ForEach(todoLists.indices, id: \.self) { index in
                    HStack {
                        Button(action: {
                            todoLists[index].isChecked.toggle()
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
