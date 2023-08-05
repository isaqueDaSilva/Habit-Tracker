//
//  HabitViewModel.swift
//  HabitTracker
//
//  Created by Isaque da Silva on 03/08/23.
//

import Foundation

class HabitViewModel: ObservableObject {
    @Published var habits = [Habit]() {
        didSet {
            if let encoderHabits = try? JSONEncoder().encode(habits) {
                UserDefaults.standard.set(encoderHabits, forKey: "Habit")
            }
        }
    }
    
    init() {
        if let saveHabit = UserDefaults.standard.data(forKey: "Habit") {
            if let decoderHabits = try? JSONDecoder().decode([Habit].self, from: saveHabit) {
                habits = decoderHabits
                return
            }
        }
        habits = []
    }
    
    func removeRows(at offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
    }
    
    func addNewHabit(name: String, description: String, icone: String, repeatIn: Repeat, priority: Priority) {
        let habit = Habit(name: name, description: description, icone: icone, repeatIn: repeatIn, priority: priority)
        habits.append(habit)
    }
    
    func addNewActivity(habit: Habit, date: Date, rate: Rate) {
        let habit = habit
        let activitys = Habit.ActivityRecord(date: date, rate: rate)
        
        if let i = habits.firstIndex(of: habit) {
            habits[i].activityRecord.append(activitys)
        }
    }
}
