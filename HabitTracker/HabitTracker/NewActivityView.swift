//
//  NewActivityView.swift
//  HabitTracker
//
//  Created by Isaque da Silva on 04/08/23.
//

import SwiftUI

struct NewActivityView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: HabitViewModel
    let activity: Habit
    var previousActivity: [Habit.ActivityRecord]
    
    @State private var date = Date.now
    @State private var rate: Rate = .good
    var body: some View {
        NavigationView {
            List {
                Section("New Record") {
                    DatePicker("Date:", selection: $date, displayedComponents: .date)
                    Picker("Rate", selection: $rate) {
                        ForEach(Rate.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                if !previousActivity.isEmpty {
                    Section("Previous Activity") {
                        NavigationLink(destination: {
                            List {
                                Section("Activitys") {
                                    ForEach(previousActivity) { previous in
                                        HStack {
                                            Text(viewModel.dateFormatter.string(from: previous.date))
                                            Spacer()
                                            Text(previous.rate.rawValue)
                                        }
                                    }
                                }
                            }
                            .navigationTitle("Previous Activity")
                        }, label: {
                            Text("Previous Activity")
                        })
                    }
                }
            }
            .navigationTitle("New Activity")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("OK", action: {
                    viewModel.addNewActivity(habit: activity, date: date, rate: rate)
                    dismiss()
                })
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

struct NewActivityView_Previews: PreviewProvider {
    static let dummyData = Habit(name: "", description: "", icone: "", repeatIn: .oneTime, priority: .high)
    static var previews: some View {
        NewActivityView(viewModel: HabitViewModel(), activity: dummyData, previousActivity: [Habit.ActivityRecord]())
    }
}
