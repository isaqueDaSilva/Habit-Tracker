//
//  AddActivityRecord.swift
//  HabitTracker
//
//  Created by Isaque da Silva on 03/08/23.
//

import Foundation

class AddActivityRecord: ObservableObject {
    @Published var activityRecord = [ActivityRecord]() {
        didSet {
            if let encoderActivityRecord = try? JSONEncoder().encode(activityRecord) {
                UserDefaults.standard.set(encoderActivityRecord, forKey: "Activity Record")
            }
        }
    }
    
    init() {
        if let saveActivity = UserDefaults.standard.data(forKey: "Activity Record") {
            if let decodeActivityRecord = try? JSONDecoder().decode([ActivityRecord].self, from: saveActivity) {
                activityRecord = decodeActivityRecord
            }
        }
        activityRecord = []
    }
}
