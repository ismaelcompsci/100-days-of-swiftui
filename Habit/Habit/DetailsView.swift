//
//  DetailsView.swift
//  Habit
//
//  Created by Mirna Olvera on 1/5/24.
//

import SwiftUI

struct DetailsView: View {
    var activity: Activity
    var activities: Activities

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text(activity.description)
                    .background(.red)

                Spacer()

                HStack {
                    Button("Activity completed", systemImage: "plus") {
                        if let index = activities.activities.firstIndex(of: activity) {
                            let newActivity = Activity(title: activity.title, description: activity.description, completionCount: activity.completionCount + 1, id: activity.id)

                            activities.activities[index] = newActivity
                        }
                    }
                    .buttonStyle(.borderedProminent)

                    Spacer()

                    Text("\(activity.completionCount)")
                        .font(.title)
                }
            }
            .navigationTitle(activity.title)
            .padding()
        }
    }
}

#Preview {
    let activites = Activities()

    return DetailsView(activity: activites.activities[0], activities: activites)
}
