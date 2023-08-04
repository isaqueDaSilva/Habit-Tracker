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
    
    @State private var date = Date.now
    @State private var rate: Rate = .good
    var body: some View {
        NavigationView {
            List {
                Section {
                    DatePicker("Date:", selection: $date, displayedComponents: .date)
                    Picker("Rate", selection: $rate) {
                        ForEach(Rate.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("New Activity")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("OK", action: {
                    viewModel.addNewActivity(date: date, rate: rate)
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
    static var previews: some View {
        NewActivityView(viewModel: HabitViewModel())
    }
}
