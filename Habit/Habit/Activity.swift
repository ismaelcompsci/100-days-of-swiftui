//
//  Activity.swift
//  Habit
//
//  Created by Mirna Olvera on 1/5/24.
//

import Foundation

struct Activity: Identifiable, Codable, Equatable {
    let title: String
    let description: String
    var completionCount: Int = 0

    var id = UUID()
}

@Observable
class Activities {
    var activities = [Activity]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
        }
    }

    init() {
        if let data = UserDefaults.standard.data(forKey: "Activities") {
            if let decoded = try? JSONDecoder().decode([Activity].self, from: data) {
                activities = decoded
                return
            }
        }

        activities = []
    }
}
