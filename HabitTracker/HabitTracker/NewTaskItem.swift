//
//  NewTaskItem.swift
//  HabitTracker
//
//  Created by Isaque da Silva on 01/08/23.
//

import Foundation

class NewTaskItem: ObservableObject {
    @Published var tasks = [TaskItems]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoderItem = try? encoder.encode(tasks) {
                UserDefaults.standard.set(encoderItem, forKey: "Task Item")
            }
        }
    }
    
    init() {
        let decoder = JSONDecoder()
        
        if let saveItems = UserDefaults.standard.data(forKey: "Task Item") {
            if let decoderTask = try? decoder.decode([TaskItems].self, from: saveItems) {
                tasks = decoderTask
            }
        }
        tasks = []
    }
}
