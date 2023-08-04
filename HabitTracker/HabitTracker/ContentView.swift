//
//  ContentView.swift
//  HabitTracker
//
//  Created by Isaque da Silva on 01/08/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = HabitViewModel()
    
    @State private var searchTerm: String = ""
    @State private var showingNewHabitView = false
    
    var search: [Habit] {
        guard !searchTerm.isEmpty else { return viewModel.habits }
        return viewModel.habits.filter { $0.name.contains(searchTerm) }
    }
    var body: some View {
        NavigationView {
            List {
                ForEach(search) { search in
                    NavigationLink(destination: {
                        
                    }, label: {
                        Image(systemName: search.icone)
                        Text(search.name)
                    })
                }
                .onDelete(perform: viewModel.removeRows)
            }
            .navigationTitle("Habit Tracker")
            .searchable(text: $searchTerm, prompt: "Search Habit")
            .toolbar {
                Button(action: {
                    showingNewHabitView = true
                }, label: {
                    Image(systemName: "plus")
                })
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingNewHabitView) {
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
