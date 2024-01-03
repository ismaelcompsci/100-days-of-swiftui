//
//  ContentView.swift
//  socket
//
//  Created by Mirna Olvera on 12/27/23.
//

import SwiftUI
import SystemConfiguration

struct Slider: View {
    @Binding var percentage: Double
    @Binding var dragging: Bool

    var onEnded: (() -> Void)? = nil

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundStyle(.tertiary)
                Rectangle()
                    .foregroundStyle(dragging ? Color.primary : Color.primary.opacity(0.8))
                    .frame(width: geometry.size.width * CGFloat(self.percentage / 100))
            }
            .cornerRadius(7)
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged { value in
                    percentage = min(max(0, Double(value.location.x / geometry.size.width * 100)), 100)
                    dragging = true
                }
                .onEnded { _ in
                    dragging = false
                    onEnded?()
                }
            )
        }
        .frame(height: dragging ? 10 : 7)
        .animation(.easeInOut, value: dragging)
    }
}

struct ContentView: View {
    @ObservedObject var websocket = Websocket()
    @State private var percentage: Double = 99.0
    @State private var dragging: Bool = false

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
