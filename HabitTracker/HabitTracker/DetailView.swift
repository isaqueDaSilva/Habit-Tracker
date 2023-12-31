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
    var timeRemaining: Int
    var progress: CGFloat
    
    var body: some View {
        List{
            if Int(progress) == repeatIn.rawValue {
                Section {
                    HStack {
                        Text("🥳")
                            .padding()
                            .font(.system(size: 30))
                            .background {
                                Rectangle()
                                    .cornerRadius(10)
                            }
                        VStack(alignment: .center){
                            Text("Good Week!")
                                .font(.title3.bold())
                            Text("Congratulations, you've completed your activity goal for this week. Keep it up 😉")
                                .font(.subheadline.bold())
                                .multilineTextAlignment(.center)
                        }
                    }
                    .frame(maxHeight: 100)
                }
            }
            
            ZStack {
                Circle()
                    .stroke(.black.opacity(0.3), style: StrokeStyle(lineWidth: 20))
                    .padding([.top, .bottom, .horizontal])
                
                Circle()
                    .trim(from: 0, to: progress / CGFloat(repeatIn.rawValue))
                    .stroke(.blue, style: StrokeStyle(lineWidth: 16, lineCap: .round, lineJoin: .round))
                    .rotationEffect(Angle(degrees: -90))
                    .animation(Animation.easeInOut(duration: 2), value: progress)
                    .padding([.top, .bottom, .horizontal])
                
                VStack {
                    Image(systemName: icone)
                        .font(.system(size: 80))
                    
                    Text("\(activityRecord.count)/\(repeatIn.rawValue)")
                        .font(.headline.bold())
                        .padding(.top)
                    Text("Time Remaining: \(timeRemaining) \(timeRemaining > 1 ? "Days" : "Day")")
                        .font(.subheadline.bold())
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
        }
        .navigationTitle(name)
        .navigationBarTitleDisplayMode(.inline)
        .onReceive(viewModel.timer, perform: { _ in
            viewModel.updateWeek(habit: activity)
        })
        .toolbar {
            Button(action: {
                recordNewActivity = true
            }, label: {
                Image(systemName: "plus")
            })
        }
        .sheet(isPresented: $recordNewActivity) {
            NewActivityView(viewModel: viewModel, activity: activity, previousActivity: previousActivity)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static let dummyData = Habit(name: "", description: "", icone: "", repeatIn: .oneTime, priority: .high)
    static var previews: some View {
        DetailView(viewModel: HabitViewModel(), activity: dummyData, name: "", description: "", icone: "", repeatIn: .oneTime, priority: .high, activityRecord: [Habit.ActivityRecord](), previousActivity: [Habit.ActivityRecord](), timeRemaining: 0, progress: 0)
    }
}
