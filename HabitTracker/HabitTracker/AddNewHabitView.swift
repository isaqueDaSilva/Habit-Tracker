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
    
    @State private var icone = "book.fill"
    @State private var name = ""
    @State private var notes = ""
    @State private var startingDate = Date.now
    @State private var showingDatePicker = false
    @State private var endDate = Date.now
    @State private var priority: Priority = .none
    
    var images = ImagesNames()
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of Habit", text: $name)
                    TextField("Notes", text: $notes)
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
                
                Section("Select an icon for the new habit:") {
                    Picker("Select Icone", selection: $icone) {
                        ForEach(images.names, id: \.self) { image in
                            Image(systemName: image)
                        }
                    }
                }
            }
            .navigationTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Add", action: {
                    
                    dismiss()
                })
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
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
