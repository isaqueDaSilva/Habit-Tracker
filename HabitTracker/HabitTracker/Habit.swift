//
//  Habit.swift
//  HabitTracker
//
//  Created by Isaque da Silva on 03/08/23.
//

import Foundation

struct Habit: Identifiable, Codable {
    var id = UUID()
    
    let name: String
    let description: String
    let icone: String
    let repeatIn: Repeat
    let priority: Priority
}


enum Repeat: Int, Codable, CaseIterable {
    case oneTime = 1
    case twoTimes = 2
    case threeTimes = 3
    case fourTimes = 4
    case fiveTimes = 5
    case sixTimes = 6
    case allWeek = 7
}

enum Priority: String, Codable, CaseIterable {
    case low = "Low Priority"
    case medium = "Medium Priority"
    case high = "High Priority"
    case none = "None Priority"
}
