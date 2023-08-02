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
    
    @State private var icone = images.names[0]
    @State private var name = ""
    @State private var notes = ""
    @State private var startingDate = Date.now
    @State private var showingDatePicker = false
    @State private var endDate = Date.now
    @State private var priority: Priority = .none
    
    static var images = ImagesNames()
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of Habit", text: $name)
                    Picker("Select the Habit Icone", selection: $icone) {
                        ForEach(AddNewHabitView.images.names, id: \.self) { image in
                            Image(systemName: image)
                        }
                    }
                }
                
                Section {
                    Toggle(isOn: $showingDatePicker.animation(), label: {
                        HStack {
                            Image(systemName: "calendar")
                            Text("Date")
                        }
                    })
                    
                    if showingDatePicker {
                        DatePicker("Select Date:", selection: $startingDate)
                            .datePickerStyle(.graphical)
                    }
                }
                
                Section("Notes:") {
                    TextEditor(text: $notes)
                }
            }
            .navigationTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("OK", action: {
                    let item = HabitType(icone: icone, name: name, note: notes, startDate: startingDate, endDate: endDate, priority: priority)
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
