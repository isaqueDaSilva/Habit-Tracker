//
//  NewHabitType.swift
//  HabitTracker
//
//  Created by Isaque da Silva on 01/08/23.
//

import Foundation

class NewHabitType: ObservableObject {
    @Published var habit = [HabitType]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoderItem = try? encoder.encode(habit) {
                UserDefaults.standard.set(encoderItem, forKey: "Habit Item")
            }
        }
    }
    
}
