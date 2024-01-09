//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Mirna Olvera on 1/8/24.
//

import SwiftUI
//
// struct Response: Codable {
//    var results: [Result]
// }
//
// struct Result: Codable {
//    var trackId: Int
//    var trackName: String
//    var collectionName: String
// }
//
// struct ITunesSearch: View {
//    @State private var results = [Result]()
//
//    func loadData() async {
//        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
//            print("Invalid URL")
//            return
//        }
//
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
//                results = decodedResponse.results
//            }
//        } catch {
//            print("Invalid data")
//        }
//    }
//
//    var body: some View {
//        List(results, id: \.trackId) { item in
//            VStack(alignment: .leading) {
//                Text(item.trackName)
//                    .font(.headline)
//
//                Text(item.collectionName)
//            }
//        }
//        .task {
//            await loadData()
//        }
//    }
// }
//
// struct AsyncImageLearn: View {
//    var body: some View {
//        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
//            if let image = phase.image {
//                image
//                    .resizable()
//                    .scaledToFit()
//            } else if phase.error != nil {
//                Text("There was an error loading the image")
//            } else {
//                ProgressView()
//            }
//        }
//        .frame(width: 200, height: 200)
//    }
// }
//
// @Observable
// class User: Codable {
//    enum CodingKeys: String, CodingKey {
//        case _name = "name"
//    }
//
//    var name = "Taylor"
// }

struct ContentView: View {
    @State private var order = Order()

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }

                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3 ... 20)
                }

                Section {
                    Toggle("Any special request?", isOn: $order.specialRequestEnabled)

                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }

                Section {
                    NavigationLink("Delivery details") {
                        AddressView(order: order)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}
