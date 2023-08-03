//
//  ContentView.swift
//  HabitTracker
//
//  Created by Isaque da Silva on 01/08/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var habitsType = AddHabitType()
    @State private var searchTerm = ""
    @State private var creatingNewHabit = false
    
    var searchHabit: [HabitType] {
        guard !searchTerm.isEmpty else { return habitsType.habits }
        return habitsType.habits.filter { $0.name.contains(searchTerm) }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchHabit) { habit in
                    NavigationLink(destination: {
                        DetailView(habits: habitsType, name: habit.name, notes: habit.note ?? "", goal: habit.goal, priority: habit.priority, icone: habit.icone)
                    }, label: {
                        HStack {
                            Text(habit.priority != .none ? habit.priority.rawValue : "")
                            Image(systemName: habit.icone)
                            Text(habit.name)
                        }
                    })
                }
                .onDelete(perform: removeRows)
            }
            .navigationTitle("Habit Tracker")
            .searchable(text: $searchTerm, prompt: "Search Habit")
            .toolbar {
                Button(action: {
                    creatingNewHabit = true
                }, label: {
                    Image(systemName: "plus")
                })
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content: {
                    EditButton()
                })
            }
            .sheet(isPresented: $creatingNewHabit, content: {
                AddNewHabitView(habit: habitsType)
            })
        }
    }
    
    func removeRows(of offset: IndexSet) {
        habitsType.habits.remove(atOffsets: offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
