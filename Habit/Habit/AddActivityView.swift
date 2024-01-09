//
//  AddActivityView.swift
//  Habit
//
//  Created by Mirna Olvera on 1/5/24.
//

import SwiftUI

struct AddActivityView: View {
    @State private var title = ""
    @State private var description = ""

    var activities: Activities

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section("Title") {
                    TextField("Title", text: $title)
                }

                Section("Description") {
                    TextEditor(text: $description)
                        .frame(minHeight: 100)
                }
            }

            .navigationTitle("New Activity")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        activities.activities.append(Activity(title: title, description: description))
                        dismiss()
                    }
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    let activities = Activities()

    return AddActivityView(activities: activities)
}
