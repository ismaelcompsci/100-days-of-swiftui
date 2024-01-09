//
//  ContentView.swift
//  socket
//
//  Created by Mirna Olvera on 12/27/23.
//

import SocketIO
import SwiftUI

struct ContentView: View {
    @ObservedObject var service = Service()
    @State private var percentage: Double = 99.0
    @State private var dragging: Bool = false

    var body: some View {
        VStack {
            Text("Messages")
                .font(.largeTitle)
//
//            List(websocket.messages, id: \.self) { message in
//                Text(message)
//            }
        }
    }
}

final class Service: ObservableObject {
    @Published var manager = SocketManager(socketURL: URL(string: "ws://127.0.0.1:8080")!, config: [.log(true), .compress])
    @Published var messages = [String]()

    init() {
        let socket = manager.defaultSocket

        socket.on(clientEvent: .connect) { _, _ in
            print("socket connected")
        }

        socket.on(clientEvent: .ping) { _, _ in
            print("PING")
        }

        socket.on(clientEvent: .pong) { _, _ in
            print("PONG")
        }

        socket.onAny { data in
            print("HELO \(data)")
        }

        socket.connect(withPayload: ["HELLO": "YES"])

        socket.emit("HI", ["HELLO"])
    }
}

#Preview {
    ContentView()
}
