//
//  ToDoView.swift
//  practiceApp
//
//  Created by mizuno on 2024/04/19.
//

import SwiftUI


struct ToDoItem {
    var isChecked: Bool
    var task: String
}

struct ToDoView: View {
    
    @State private var newTask: String = ""
    @State private var todoLists: [ToDoItem] = [
    ]
    
    var body: some View {
        VStack {
            Text("ToDoList")
                .font(.system(size: 30, weight: .bold, design: .default))
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
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

                    newTask = ""
                })
                .padding(.trailing, 20)
            }
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
        Spacer()
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
