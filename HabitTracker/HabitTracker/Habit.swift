//
//  Habit.swift
//  HabitTracker
//
//  Created by Isaque da Silva on 03/08/23.
//

import Foundation


//Object
struct Habit: Identifiable, Codable, Equatable {
    static func == (lhs: Habit, rhs: Habit) -> Bool {
        return lhs.name == rhs.name && lhs.id == rhs.id
    }
    
    struct ActivityRecord: Identifiable, Codable {
        var id = UUID()
        
        let date: Date
        let rate: Rate
    }
    
    var id: Int = UUID().hashValue
    
    let name: String
    let description: String
    let icone: String
    let repeatIn: Repeat
    let priority: Priority
    var activityRecord = [ActivityRecord]()
    var previousActivity = [ActivityRecord]()
    var timeRemaining = 60
    var progress: CGFloat = 0
    
    static var iconeSystemName = [
        "book.fill",
        "books.vertical.fill",
        "studentdesk",
        "curlybraces",
        "ellipsis.curlybraces",
        "bed.double.fill",
        "drop.fill",
        "figure.run",
        "figure.2.and.child.holdinghands",
        "music.note"
    ]
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

enum Rate: String, Codable, CaseIterable {
    case bad = "😔"
    case medium = "😐"
    case good = "😁"
}
