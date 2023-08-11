//
//  NewHabitView.swift
//  HabitTracker
//
//  Created by Isaque da Silva on 03/08/23.
//

import SwiftUI

struct NewHabitView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: HabitViewModel
    
    var body: some View {
        NavigationView {
            List {
                Section("Details:") {
                    TextField("Insert Name", text: $viewModel.name)
                    
                    Picker("Priority:", selection: $viewModel.priority) {
                        ForEach(Priority.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    
                    Picker("Repeat:", selection: $viewModel.repeatIn) {
                        ForEach(Repeat.allCases, id: \.self) {
                            Text("\($0.rawValue)x a Week")
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                    Picker("Select the Habit Icone:", selection: $viewModel.icone) {
                        ForEach(Habit.iconeSystemName, id: \.self) {
                            Image(systemName: $0)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Description") {
                    TextEditor(text: $viewModel.description)
                }
            }
            .navigationTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button(action: {
                    viewModel.addNewHabit(name: viewModel.name, description: viewModel.description, icone: viewModel.icone, repeatIn: viewModel.repeatIn, priority: viewModel.priority)
                    dismiss()
                }, label: {
                    Text("OK")
                })
                .disabled(viewModel.name.isEmpty)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", action: {
                        dismiss()
                    })
                }
            }
        }
    }
}

struct NewHabitView_Previews: PreviewProvider {
    static var previews: some View {
        NewHabitView(viewModel: HabitViewModel())
    }
}
