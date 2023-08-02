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
                Section {
                    ForEach(searchHabit) { habit in
                        NavigationLink(destination: {
                            
                        }, label: {
                            
                        })
                    }
                    .onDelete(perform: removeRows)
                }
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
            .sheet(isPresented: $creatingNewHabit, content: {
                AddNewHabitView(habit: AddHabitType())
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content: {
                    EditButton()
                })
            }
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
