//
//  ContentView.swift
//  Habit
//
//  Created by Mirna Olvera on 1/5/24.
//

import SwiftUI

struct ContentView: View {
    @State private var activities = Activities()
    @State private var showForm = false

    var navigationTitle: String {
        "Activities (\(activities.activities.count))"
    }

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(activities.activities) { activity in
                        NavigationLink {
                            DetailsView(activity: activity, activities: activities)
                        } label: {
                            HStack {
                                Text(activity.title)
                                Spacer()
                                Text("\(activity.completionCount)")
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle(navigationTitle)
            .toolbar {
                ToolbarItem(id: "new activity") {
                    Button("new", systemImage: "plus.circle") {
                        showForm = true
                    }
                }
            }
            .sheet(isPresented: $showForm) {
                AddActivityView(activities: activities)
            }
        }
    }
}

#Preview {
    ContentView()
}
