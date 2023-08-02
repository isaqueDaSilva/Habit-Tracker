//
//  HabitType.swift
//  HabitTracker
//
//  Created by Isaque da Silva on 01/08/23.
//

import Foundation

struct HabitType: Identifiable, Codable {
    var id = UUID()
    let icone: String
    let name: String
    let note: String?
    let priority: Priority
    let goal: GoalPerWeek
}
