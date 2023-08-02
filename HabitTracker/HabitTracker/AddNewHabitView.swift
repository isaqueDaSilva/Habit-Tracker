//
//  AddNewHabitView.swift
//  HabitTracker
//
//  Created by Isaque da Silva on 01/08/23.
//

import SwiftUI

struct AddNewHabitView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var habit: AddHabitType
    
    @State private var name = ""
    @State private var priority: Priority = .none
    @State private var goal: GoalPerWeek = .oneTime
    @State private var icone = images.names[0]
    @State private var notes = ""
    
    
    static var images = ImagesNames()
    
    var body: some View {
        NavigationView {
            Form {
                Section("Details:") {
                    TextField("Name of Habit", text: $name)
                    
                    Picker("Priority", selection: $priority) {
                        ForEach(Priority.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                    Picker("Goal", selection: $goal) {
                        ForEach(GoalPerWeek.allCases, id: \.self) {
                            Text("\($0.rawValue)x a week")
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                    Picker("Select the Habit Icone", selection: $icone) {
                        ForEach(AddNewHabitView.images.names, id: \.self) { image in
                            Image(systemName: image)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Notes:") {
                    TextEditor(text: $notes)
                }
            }
            .navigationTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("OK", action: {
                    let item = HabitType(icone: icone, name: name, note: notes, priority: priority, goal: goal)
                    habit.habits.append(item)
                    dismiss()
                })
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        HStack {
                            Text("Cancel")
                        }
                    })
                }
            }

        }
    }
}

struct AddNewHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewHabitView(habit: AddHabitType())
    }
}
