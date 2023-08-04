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
            }
            .navigationTitle("Habit Tracker")
            .searchable(text: $searchTerm, prompt: "Search Habit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
