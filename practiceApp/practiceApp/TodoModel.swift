//
//  TodoModel.swift
//  practiceApp
//
//  Created by mizuno on 2024/04/25.
//

import Foundation

func saveToDoTask(todoLists:[ToDoItem]) {
    do {
        let encoder = JSONEncoder()
        let todoData = try encoder.encode(todoLists)
        
        // JSONデータをUserDefaultsに保存
        UserDefaults.standard.set(todoData, forKey: "key")
    } catch {
        print("エラー：Failed Encode Json")
    }
}

func deleteToDoTask(todoLists: [ToDoItem]) -> [ToDoItem] {
    
    var changeToDos = todoLists
    
    var indexesToRemove: [Int] = []

    for index in todoLists.indices {
        if todoLists[index].isChecked {
            indexesToRemove.append(index)
        }
    }

    for index in indexesToRemove.reversed() {
        changeToDos.remove(at: index)
    }
    saveToDoTask(todoLists: changeToDos)
    return changeToDos
}
