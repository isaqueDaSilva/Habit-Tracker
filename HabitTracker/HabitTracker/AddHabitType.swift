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
            if let encoderItem = try? JSONEncoder().encode(habits) {
                UserDefaults.standard.set(encoderItem, forKey: "Habit Item")
            }
        }
    }
    
    init() {
        if let saveHabits = UserDefaults.standard.data(forKey: "Habit Item") {
            if let decoderHabit = try? JSONDecoder().decode([HabitType].self, from: saveHabits) {
                habits = decoderHabit
                return
            }
        }
        habits = []
    }
}
