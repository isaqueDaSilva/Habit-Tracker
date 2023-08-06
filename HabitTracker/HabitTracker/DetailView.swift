//
//  DetailView.swift
//  HabitTracker
//
//  Created by Isaque da Silva on 04/08/23.
//

import SwiftUI

struct DetailView: View {
    @State private var recordNewActivity = false
    @ObservedObject var viewModel: HabitViewModel
    let activity: Habit
    
    var name: String
    var description: String
    var icone: String
    var repeatIn: Repeat
    var priority: Priority
    var activityRecord: [Habit.ActivityRecord]
    
    var body: some View {
        NavigationView {
            List{
                Section {
                    ZStack {
                        ProgressBar(progress: $viewModel.progress, to: repeatIn.rawValue, color: .blue)
                            .padding([.top, .bottom, .horizontal])
                        
                        Image(systemName: icone)
                            .font(.system(size: 80))
                    }
                }
                
                if !description.isEmpty {
                    Section("Description:") {
                        Text(description)
                    }
                }
                
                Section("Detail:") {
                    HStack {
                        Text("Repeat In:")
                        Spacer()
                        Text("\(repeatIn.rawValue)x a Week")
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Text("Priority:")
                        Spacer()
                        Text(priority.rawValue)
                            .foregroundColor(.gray)
                    }
                }
                
                Section("Activity Records") {
                    ForEach(activityRecord) { activity in
                        HStack {
                            Text(viewModel.dateFormatter.string(from: activity.date))
                            Spacer()
                            Text(activity.rate.rawValue)
                        }
                    }
                }
            }
        }
        .navigationTitle(name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button(action: {
                recordNewActivity = true
            }, label: {
                Image(systemName: "plus")
            })
        }
        .sheet(isPresented: $recordNewActivity) {
            NewActivityView(viewModel: viewModel, activity: activity)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static let dummyData = Habit(name: "", description: "", icone: "", repeatIn: .oneTime, priority: .high)
    static var previews: some View {
        DetailView(viewModel: HabitViewModel(), activity: dummyData, name: "", description: "", icone: "", repeatIn: .oneTime, priority: .high, activityRecord: [Habit.ActivityRecord]())
    }
}
