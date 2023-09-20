//
//  Model.swift
//  DoitSometing_Memo
//
//  Created by kiakim on 2023/09/18.
//

import Foundation

//[Q] codable?
struct TodoData: Codable {
//    var id: Int
//    var date: String
    var contents : String
    var isDone : Bool
}


var contentsList: [TodoData] = [
    TodoData( contents: "userDefaults 적용", isDone: true),
    TodoData( contents: "Core Data 적용", isDone: false)
]

class TodoDataManager {
    static let shared = TodoDataManager()
    
    
    
    //userDefaluts를 사용할 때는 decode된 내용을 save하고 load하는 과정이 필요
    //saveUserDefaluts 작성
    //loadUserDefaluts 작성
    //여기에 배치시키는 이유 전역에서 사용이 가능하도록
    
    func addTodoItem(contets: String, isDone: Bool = false){
        let newTodo = TodoData(contents: contets, isDone: isDone)
        contentsList.append(newTodo)
    }

    func saveUserDefaluts (){
        UserDefaults.standard.set(try? JSONEncoder().encode(contentsList),forKey: "addTodoData")
    }
    
    func loadUserDefaluts (){
      if let encodeData = UserDefaults.standard.data(forKey: "addTodoData"),
         let saveTodoItem = try? JSONDecoder().decode([TodoData].self, from: encodeData){
          contentsList = saveTodoItem
      }
        
    }
    

    
}

