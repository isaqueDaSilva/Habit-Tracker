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
    var previousActivity: [Habit.ActivityRecord]
    
    var body: some View {
        List{
            Section {
                ZStack {
                    
                    Circle()
                        .stroke(.black.opacity(0.3), style: StrokeStyle(lineWidth: 20))
                        .padding([.top, .bottom, .horizontal])
                    
                    Circle()
                        .trim(from: 0, to: viewModel.progress(activityRecord: activityRecord, repeatIn: repeatIn))
                        .stroke(.blue, style: StrokeStyle(lineWidth: 20))
                        .rotationEffect(Angle(degrees: -90))
                        .padding([.top, .bottom, .horizontal])
                    
                    VStack {
                        Image(systemName: icone)
                            .font(.system(size: 80))
                        
                        Text("\(activityRecord.count)/\(repeatIn.rawValue)")
                            .font(.headline.bold())
                            .padding(.top)
                    }
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
            
            if !activityRecord.isEmpty {
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
            
            Section("Previous Activity") {
                NavigationLink(destination: {
                    List {
                        ForEach(previousActivity) { previous in
                            HStack {
                                Text(viewModel.dateFormatter.string(from: previous.date))
                                Spacer()
                                Text(previous.rate.rawValue)
                            }
                        }
                    }
                    .navigationTitle("Previous Activity")
                }, label: {
                    Text("Previous Activity")
                })
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
        DetailView(viewModel: HabitViewModel(), activity: dummyData, name: "", description: "", icone: "", repeatIn: .oneTime, priority: .high, activityRecord: [Habit.ActivityRecord](), previousActivity: [Habit.ActivityRecord]())
    }
}
