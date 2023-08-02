//
//  TaskItems.swift
//  HabitTracker
//
//  Created by Isaque da Silva on 01/08/23.
//

import Foundation

struct TaskItems: Identifiable, Codable {
    var id = UUID()
    
    let name: String
    let note: String?
    let startDate: Date
    let endDate: Date?
    let startHour: Date
    let endHour: Date?
    let priority: Priority
}
