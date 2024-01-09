//
//  Mission.swift
//  Moonshot
//
//  Created by Mirna Olvera on 1/3/24.
//

import SwiftUI

struct Mission: Codable, Identifiable, Hashable {
    struct CrewRole: Codable, Hashable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String

    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }

    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }

    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}
