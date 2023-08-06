//
//  ContentView.swift
//  HabitTracker
//
//  Created by Isaque da Silva on 01/08/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = HabitViewModel()
    
    @State private var showingNewHabitView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.search) { search in
                    NavigationLink(destination: {
                        DetailView(viewModel: viewModel, activity: search, name: search.name, description: search.description, icone: search.icone, repeatIn: search.repeatIn, priority: search.priority, activityRecord: search.activityRecord, previusActivity: search.previusActivity)
                    }, label: {
                        Image(systemName: search.icone)
                        Text(search.name)
                    })
                }
                .onDelete(perform: viewModel.removeRows)
            }
            .navigationTitle("Habit Tracker")
            .searchable(text: $viewModel.searchTerm, prompt: "Search Habit")
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
                NewHabitView(viewModel: viewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
