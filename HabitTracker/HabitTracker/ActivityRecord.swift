//
//  ActivityRecord.swift
//  HabitTracker
//
//  Created by Isaque da Silva on 03/08/23.
//

import Foundation


struct ActivityRecord: Identifiable, Codable {
    var id = UUID()
    
    let date: Date
    let rate: Int
}
