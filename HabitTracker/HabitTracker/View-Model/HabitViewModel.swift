//
//  HabitViewModel.swift
//  HabitTracker
//
//  Created by Isaque da Silva on 03/08/23.
//

import Foundation
import SwiftUI

class HabitViewModel: ObservableObject {
    @Published var habits = [Habit]() {
        didSet {
            if let encoderHabits = try? JSONEncoder().encode(habits) {
                UserDefaults.standard.set(encoderHabits, forKey: "Habit")
            }
        }
    }
    
    @Published var searchTerm: String = ""
    
    @Published var showingAlert = false
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    var search: [Habit] {
        guard !searchTerm.isEmpty else { return habits }
        return habits.filter { $0.name.contains(searchTerm) }
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
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
            habits[i].previousActivity.append(activitys)
            
            if Int(habits[i].progress) < habits[i].repeatIn.rawValue {
                habits[i].progress += 1
            }
        }
    }
    
    func updateWeek(habit: Habit) {
        let habit = habit
        if let i = habits.firstIndex(of: habit) {
            if habits[i].timeRemaining > 0 {
                habits[i].timeRemaining -= 1
            } else {
                habits[i].activityRecord.removeAll()
                habits[i].timeRemaining = 60
                habits[i].progress = 0
            }
        }
    }
    
    func alert(habit: Habit) {
        let habit = habit
        if let i = habits.firstIndex(of: habit) {
            if Int(habits[i].progress) == habits[i].repeatIn.rawValue {
                self.showingAlert = true
            }
        }
    }
}
