//
//  priority.swift
//  HabitTracker
//
//  Created by Isaque da Silva on 01/08/23.
//

import Foundation

enum Priority: String, Codable, CaseIterable {
    case none = "None"
    case low = "!"
    case medium = "!!"
    case high = "!!!"
}

enum GoalPerWeek: Int, Codable, CaseIterable {
    case oneTime = 1
    case twoTimes = 2
    case treeTimes = 3
    case fourTimes = 4
    case fiveTimes = 5
    case sixTimes = 6
    case allWeek = 7
}
