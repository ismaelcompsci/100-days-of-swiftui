//
//  ContentView.swift
//  socket
//
//  Created by Mirna Olvera on 12/27/23.
//

import SwiftUI
import SystemConfiguration

struct ContentView: View {
    @ObservedObject var websocket = Websocket()

    var body: some View {
        VStack {
            Text("Messages")
                .font(.largeTitle)
            List(websocket.messages, id: \.self) { message in
                Text(message)
            }
        }
    }
}

class Websocket: ObservableObject {
    @Published var messages = [String]()

    private var webSocketTask: URLSessionWebSocketTask?

    init() {
        connect()
    }

    private func connect() {
        guard let url = URL(string: "ws://192.168.1.180:5006/") else {
            print("FAILED URL")
            return
        }

        let request = URLRequest(url: url)

        webSocketTask = URLSession.shared.webSocketTask(with: request)

        webSocketTask?.resume()
        reciveMessage()
    }

    private func reciveMessage() {
        webSocketTask?.receive { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let message):
                switch message {
                case .string(let text):
                    self.messages.append(text)
                case .data(let data):
                    print(data)
                default:
                    break
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
