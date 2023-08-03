//
//  DetailView.swift
//  HabitTracker
//
//  Created by Isaque da Silva on 02/08/23.
//

import SwiftUI

struct DetailView: View {
    @StateObject var habits: AddHabitType
    @State private var showingActivityRecord = false
    
    var name: String
    var notes: String
    var goal: GoalPerWeek
    var priority: Priority
    var icone: String
    
    var priorityFormatter: String {
        switch priority {
        case .none:
            return "No Priority"
        case .low:
            return "Low Priority"
        case .medium:
            return "Medium Priority"
        case .high:
            return "High Priority"
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 15)
                            .fill(.gray)
                        Image(systemName: icone)
                            .font(.system(size: 80))
                            .foregroundStyle(.blue)
                    }
                    .frame(maxWidth: 350, maxHeight: 200)
                    .padding([.top, .bottom])
                }
                
                if !notes.isEmpty {
                    Section("Note:") {
                        Text(notes)
                    }
                }
                Section("Description") {
                    HStack {
                        Text("Goal:")
                        Spacer()
                        Text("\(goal.rawValue)x a week")
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Text("Priority:")
                        Spacer()
                        Text(priorityFormatter)
                            .foregroundColor(.gray)
                    }
                }
                
                Section("Activity record") {
                    
                }
            }
        }
        .navigationTitle(name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button(action: {
                showingActivityRecord = true
            }, label: {
                Image(systemName: "plus")
            })
        }
        .sheet(isPresented: $showingActivityRecord) {
            
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(habits: AddHabitType(), name: "", notes: "", goal: .oneTime, priority: .none, icone: "")
    }
}
