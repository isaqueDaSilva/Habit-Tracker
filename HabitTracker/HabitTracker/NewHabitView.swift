//
//  NewHabitView.swift
//  HabitTracker
//
//  Created by Isaque da Silva on 03/08/23.
//

import SwiftUI

struct NewHabitView: View {
    @ObservedObject var viewModel = HabitViewModel()
    
    @State private var name: String = ""
    @State private var description: String? = ""
    @State private var icone: String = ""
    @State private var repeatIn: Repeat = .oneTime
    @State private var priority: Priority = .high
    
    var body: some View {
        NavigationView {
            List {
                Section("Details:") {
                    TextField("Name:", text: $name)
                    
                    Picker("Priority", selection: $priority) {
                        ForEach(Priority.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    
                    Picker("Repeat", selection: $repeatIn) {
                        ForEach(Repeat.allCases, id: \.self) {
                            Text("\($0.rawValue)x a Week")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
            }
            .navigationTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct NewHabitView_Previews: PreviewProvider {
    static var previews: some View {
        NewHabitView()
    }
}
