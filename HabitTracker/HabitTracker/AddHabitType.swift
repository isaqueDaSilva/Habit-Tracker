//
//  NewHabitType.swift
//  HabitTracker
//
//  Created by Isaque da Silva on 01/08/23.
//

import Foundation

class AddHabitType: ObservableObject {
    @Published var habits = [HabitType]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoderItem = try? encoder.encode(habits) {
                UserDefaults.standard.set(encoderItem, forKey: "Habit Item")
            }
        }
    }
    
    init() {
        let decoder = JSONDecoder()
        
        if let saveHabits = UserDefaults.standard.data(forKey: "Habit Item") {
            if let decoderHabit = try? decoder.decode([HabitType].self, from: saveHabits) {
                habits = decoderHabit
                return
            }
        }
        habits = []
    }
}
