//
//  CrewScrollView.swift
//  Moonshot
//
//  Created by Mirna Olvera on 1/4/24.
//

import SwiftUI

struct CrewScrollView: View {
    let crew: [CrewMember]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        Image(crewMember.astronaut.id)
                            .resizable()
                            .frame(width: 104, height: 72)
                            .clipShape(.capsule)
                            .overlay(
                                Capsule()
                                    .strokeBorder(.white, lineWidth: 1)
                            )

                        VStack(alignment: .leading) {
                            Text(crewMember.astronaut.name)
                                .foregroundStyle(.white)
                                .font(.headline)

                            Text(crewMember.role)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    let crew = missions[0].crew.map { member in
        if let astronaut = astronauts[member.name] {
            return CrewMember(role: member.role, astronaut: astronaut)
        } else {
            fatalError("Missing \(member.name)")
        }
    }

    return CrewScrollView(crew: crew)
}
