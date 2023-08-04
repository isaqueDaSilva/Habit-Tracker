//
//  NewHabitView.swift
//  HabitTracker
//
//  Created by Isaque da Silva on 03/08/23.
//

import SwiftUI

struct NewHabitView: View {
    @ObservedObject var viewModel = HabitViewModel()
    
    var nome: String
    var body: some View {
        NavigationView {
            List {
                
            }
            .navigationTitle(nome)
        }
    }
}

struct NewHabitView_Previews: PreviewProvider {
    static var previews: some View {
        NewHabitView(nome: "")
    }
}
