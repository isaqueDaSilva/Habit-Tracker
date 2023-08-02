//
//  priority.swift
//  HabitTracker
//
//  Created by Isaque da Silva on 01/08/23.
//

import Foundation

enum Priority: String, Codable, CaseIterable {
    case none = "None"
    case low = "Low"
    case medium = "Medium"
    case high = "Hight"
}

enum GoalPerWeek: String, Codable, CaseIterable {
    case oneTime = "Once a Week"
    case twoTimes = "Twice a Week"
    case treeTimes = "Three Times a week"
    case fourTimes = "Four Times a Week"
    case fiveTimes = "Five Times a Week"
    case sixTimes = "Six Times a Week"
}
