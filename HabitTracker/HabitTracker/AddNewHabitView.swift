//
//  AddNewHabitView.swift
//  HabitTracker
//
//  Created by Isaque da Silva on 01/08/23.
//

import SwiftUI

struct AddNewHabitView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var habit: NewHabitType
    
    @State private var name = ""
    @State private var icone = "book.fill"
    
    var images = ImagesNames()
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of Habit", text: $name)
                    
                    Picker("Select Icone", selection: $icone) {
                        ForEach(images.names, id: \.self) { image in
                            Image(systemName: image)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                VStack{
                    Button("Add", action: {
                        let item = HabitType(name: name, icone: icone, tasks: nil)
                        habit.habits.append(item)
                        dismiss()
                    })
                    .frame(maxWidth: 430)
                    .buttonStyle(.borderedProminent)
                }
                .listRowBackground(Color(CGColor(red: 240, green: 240, blue: 246, alpha: 0)))
            }
            .navigationTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
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
        AddNewHabitView(habit: NewHabitType())
    }
}
