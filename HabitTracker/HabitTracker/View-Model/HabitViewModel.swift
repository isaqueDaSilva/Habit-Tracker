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
    
    @Published var activity = [Habit.ActivityRecord]() {
        didSet {
            if let encoderActivity = try? JSONEncoder().encode(habits) {
                UserDefaults.standard.set(encoderActivity, forKey: "Activity")
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
        
        if let saveActivity = UserDefaults.standard.data(forKey: "Activity") {
            if let decoderActivity = try? JSONDecoder().decode([Habit.ActivityRecord].self, from: saveActivity) {
                activity = decoderActivity
                return
            }
        }
        activity = []
    }
    
    func removeRows(at offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
    }
    
    func addNewHabit(name: String, description: String, icone: String, repeatIn: Repeat, priority: Priority) {
        let habit = Habit(name: name, description: description, icone: icone, repeatIn: repeatIn, priority: priority, activityRecord: activity)
        habits.append(habit)
    }
    
    func addNewActivity(date: Date, rate: Rate) {
        let activitys = Habit.ActivityRecord(date: date, rate: rate)
        activity.append(activitys)
    }
}
