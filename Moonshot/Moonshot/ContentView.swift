//
//  ContentView.swift
//  Moonshot
//
//  Created by Mirna Olvera on 1/3/24.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    @State private var showGrid = false

    var grid: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink(value: mission) {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()

                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)

                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                    }
                }
            }
        }
        .padding([.horizontal, .bottom])
    }

    var list: some View {
        VStack {
            List {
                ForEach(missions) { mission in
                    NavigationLink(value: mission) {
                        Text(mission.displayName)
                    }
                }
            }
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                if showGrid {
                    grid
                } else {
                    list
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button {
                    showGrid.toggle()
                } label: {
                    if !showGrid {
                        Image(systemName: "rectangle.grid.3x2.fill")
                    } else {
                        Image(systemName: "list.bullet")
                    }
                }
            }
            .navigationDestination(for: Mission.self) { selected in
                MissionView(mission: selected, astronauts: astronauts)
            }
        }
    }
}

#Preview {
    ContentView()
}
