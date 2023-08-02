//
//  HabitType.swift
//  HabitTracker
//
//  Created by Isaque da Silva on 01/08/23.
//

import Foundation

struct HabitType: Identifiable, Codable {
    var id = UUID()
    let name: String
    let icone: String
    let tasks: [TaskItems]
}
